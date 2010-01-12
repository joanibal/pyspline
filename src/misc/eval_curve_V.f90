subroutine eval_curve_V(s,t,k,coef,nctl,ndim,n,val)

  !***DESCRIPTION
  !
  !     Written by Gaetan Kenway
  !
  !     Abstract eval_surf is a vector version of the NURBS evaluation function
  !
  !     Description of Arguments
  !     Input
  !     s       - Real, Vector of s coordinates, length n
  !     t       - Real,Knot vector. Length nctl+k
  !     k       - Integer,order of B-spline 
  !     coef    - Real,Array of b-sline coefficients and weights. Size (nctl,ndim+1)
  !     nctl    - Integer,Number of control points
  !
  !     Ouput 
  !     val     - Real, Evaluated point, size ndim

  ! Input
  integer         , intent(in)          :: k,nctl,ndim,n
  double precision, intent(in)          :: s(n)
  double precision, intent(in)          :: t(nctl+k)
  double precision, intent(in)          :: coef(nctl,ndim+1)

  ! Output
  double precision, intent(out)         :: val(n,ndim)

  ! Working
  integer                               :: i,dim,inbv
  double precision                      :: work(3*k)
  double precision                      :: weight
  external bvalu

  inbv = 1

  do i=1,n
     ! Evaluate the weight first
     weight = bvalu(t,coef(:,ndim+1),nctl,k,0,s(i),inbv,work)

     do idim=1,ndim
        val(i,idim) = bvalu(t,coef(:,idim)*coef(:,ndim+1),nctl,k,0,s(i),inbv,work)
     end do

     val(i,:) = val(i,:)/weight
  end do

end subroutine eval_curve_V
