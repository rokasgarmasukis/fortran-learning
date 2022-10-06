program tsunami

   implicit none

   integer :: n

   integer, parameter :: grid_size = 100
   integer, parameter :: num_time_steps = 100
   real, parameter:: dt = 1, dx = 1, c = 1
   ! dt - time step [s]
   ! dx - grid spacing [m]
   ! c - phase speed [m/s]

   real :: h(grid_size)

   integer, parameter :: icenter = 25
   real, parameter :: decay = 0.02


   if (grid_size <= 0) stop 'grid_size must be > 0'
   if (dt <= 0) stop 'time step dt must be > 0'
   if (dx <= 0) stop 'grid spacing dx must be > 0'
   if (c <= 0) stop 'background flow speed c must be > 0'

   call set_gaussian(h, icenter, decay)

   print *, 0, h
   time_loop: do n = 1, num_time_steps
      h = h - c * diff(h) / dx * dt
      print *, n, h
   end do time_loop

contains

   function diff(x) result(diff_x)
      real, intent(in) :: x(:)
      real :: diff_x(size(x))
      integer :: im
      im = size(x)
      diff_x(1) = x(1) - x(im)
      diff_x(2:im) = x(2:im) - x(1:im-1)
   end function diff

   subroutine set_gaussian(x, center, decay_amount)
      real, intent(in out) :: x(:)
      integer, intent(in) :: center
      real, intent(in) :: decay_amount
      integer :: i
      do concurrent (i = 1:size(x))
         x(i) = exp(-decay_amount * (i - center)**2)
      end do
   end subroutine set_gaussian

end program tsunami


