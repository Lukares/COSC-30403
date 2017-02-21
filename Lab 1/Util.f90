module Util
    use EmployeeModule
    implicit none
    contains
    function toUpper(cmd) result(newCMD)
        character(2) :: cmd
        character(2) :: newCMD
        integer i,c
        i = 1
        do while ( i <= 2 )
            c = iachar(cmd(i:i))
            if (c >= iachar("a") .and. c <= iachar("z")) then
                newCMD(i:i) = achar(iachar(cmd(i:i)) - 32)
            else
                newCMD(i:i) = cmd(i:i)
            end if
            i = i + 1
        end do
    end function toUpper

end module Util
