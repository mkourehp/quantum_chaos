subroutine H_forming_and_Diag

  implicit none
  character ( len = 2 ) :: IC_type , IC_Dist , vt , time_type
  character(len=80):: filename
  integer , allocatable , dimension(:,:) :: cf 
  integer :: L , Nb , info , wave_f , Itteration , init_sp_position 
  integer :: i , j , k , whole_HSS , l1 ,p , m , kk , i_t , timee , iii_it , ie0
  integer(kind=8) :: bn
  real(kind=8) , allocatable , dimension(:,:)  ::  H
  real(kind=8) , allocatable , dimension(:) :: E , work , onsiteP , lmda , ic , s ,inner , MF
  real(kind=8) :: t1 , t2 , v1 , v2 , vr , ts , vs , a , t00 , tff , t_scale
  real(kind=8) :: tf , t0 , dt , t , temp_randn , var=0.d0 , E_in , E_final , tmax
  complex(kind=16) , allocatable , dimension(:,:) :: rho
  complex(kind=16) , allocatable , dimension(:)   :: wfn , rhowork
  complex(kind=16) , parameter :: ui = cmplx(0.0,1.0)


  open(1,file="data/config.in",action="read")
  read(1,*) L , p, t1 , v1 , t2 , v2 , vr, vt, ts , vs
  close(1)
  E_in = E_in / 100.d0
  E_final = E_final / 100.0
  write(*,*)
  write(*,353) "       t1       =   " , -1.d0*t1
  write(*,353) "       u1       =   " , v1
  write(*,353) "       t2       =   " , -1.d0*t2
  write(*,353) "       u2       =   " , v2
  write(*,353) "       vr       =   ", vr
  write(*,353) "       ts       =   ", -1.d0*ts
  write(*,353) "       ws       =   ", vs
  write(*,*)
  t1 = -1.d0 * t1
  t2 = -1.d0 * t2
  ts = -1.d0 * ts
  if(timee == 0 ) write(*,*) "  No time propagation"
  Nb = bn(L,p)
  whole_HSS = L*Nb
  write(*,*) " The Hilbert Space Size ", whole_HSS

  allocate(cf(whole_HSS,p+1)) ; cf = 0
  open(unit=2,file="data/configuration.dat",action="read")

  do i=1,whole_HSS
    read(2,*) cf(i,:)
  end do
  close(2)



  !Random on-site Potential
  allocate(onsiteP(L)) ; onsiteP = 0.d0

  open(unit=11,file="data/site_potentials.dat")
  if (vt == "R") then
    call random_seed()
    call random_number(OnsiteP)
    OnsiteP = vr*(2.d0*OnsiteP-1.d0)
  else if (vt == "L") then
    do i=1,L
      onsiteP(i) = -0.5 + i*1.0/(L+1.0)
    end do
    onsiteP(:) = 0.5*vr*onsiteP(:)/onsiteP(L)
  else if (vt == "Q") then
    do i=1,L
      onsiteP(i) = (-0.5 + i*1.0/(L+1.0))**2
    end do
    onsiteP(:) = vr*onsiteP(:)/onsiteP(L)
  end if 
  do i=1,L
    write(11,313) OnsiteP(i)
  end do
  close(11)

  allocate(H(whole_HSS,whole_HSS)) ; H = 0.d0
  do i=1,whole_HSS
    !diagonal elements
    H(i,i) = H(i,i) + onsiteP(cf(i,p+1))
    do j=1,p
      H(i,i) = H(i,i) + onsiteP(cf(i,j))
      if (abs(cf(i,j)-cf(i,p+1)) == 0) H(i,i) = H(i,i) + Vs
    end do
    do j=1,p-1
      do k=j,p
        if (abs(cf(i,j)-cf(i,k)) == 1) H(i,i) = H(i,i) + V1
      end do
      do k=j,p
        if (abs(cf(i,j)-cf(i,k)) == 2) H(i,i) = H(i,i) + V2
      end do
    end do

    ! in order to have a non zero off-diagonal Hamiltonian entity H(i,j), test particle position displacement must be  either zero
    ! (bath can jump) or one (bath must be freeze)

    do j=i+1,whole_HSS
      ! Bath can jump
      if (abs(cf(i,p+1) - cf(j,p+1)) == 0) then
        l1=0
        do k=1,p
          do kk=1,p
            if(cf(i,k)==cf(j,kk)) l1=l1+1
          end do
        end do
        if (l1 == p-1) then
          k  = 0
          kk = 0
          do m=1,p
            k  =  k + cf(i,m)
            kk = kk + cf(j,m)
          end do
          if (abs(k-kk) == 1) H(i,j) = t1
          if (abs(k-kk) == 2) H(i,j) = t2
        end if

        ! Test particle can jump
      else if (abs(cf(i,p+1) - cf(j,p+1)) ==1 ) then
        l1=0
        do k=1,p
          if(cf(i,k) /= cf(j,k)) l1=l1+1
        end do
        if (l1 == 0) H(i,j) = ts
      end if

      H(j,i) = H(i,j)
    end do

  end do
  allocate(E(whole_HSS)) ; E = 0.d0
  allocate(work(3*whole_HSS-1)) ; work = 0.d0
  write(*, *) "   Diagonalizing..."

  call dsyev('V','U',whole_HSS,H,whole_HSS,E,work,3*whole_HSS-1,info)

  open(unit=3,file="data/eigenenergies.dat")
  do i=1,whole_HSS
    write(3,313) E(i)
  end do
  close(3)

  if (wave_f == 1) then
    open(unit=4,file="data/eigenvectors.dat")
    do i=1,whole_HSS
      write(4,313) H(i,:)
    end do
  end if
  close(4)
  deallocate(work)
  deallocate(onsiteP)

  313 format(10000000E22.13)
  353 format(A,F9.3)
  deallocate(cf)
  deallocate(H)
  write(*,*) "DONE"
end subroutine

integer(kind=8) function bn(x,y)
  integer :: x , y
  integer(kind=8) :: fac1 , fac2 , b , a , i_count
  a = max(y,x-y)
  b = min(y,x-y)
  i = 0
  fac1 = 1
  fac2 = 1
  do i_count=a+1,x
    fac1 = fac1 * i_count
  end do
  do i_count=1,b
    fac2 = fac2 * i_count
  end do
  bn = abs(fac1/fac2)
end function

