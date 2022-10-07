module mod_initial
   use iso_fortran_env, only: int32, real32
   implicit none

contains

   subroutine set_gaussian(x, center, decay_amount)
      real(real32), intent(in out) :: x(:)
      integer(int32), intent(in) :: center
      real(real32), intent(in) :: decay_amount
      integer(int32) :: i
      do concurrent (i = 1:size(x))
         x(i) = exp(-decay_amount * (i - center)**2)
      end do
   end subroutine set_gaussian

end module mod_initial
