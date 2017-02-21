!------------------------------------------------------------
!>  Module Name:    EmployeeModule
!>  Author:         Blake Lucas and Luke Reddick
!
!>  This module acts as the "Employee" class that constructs
!   the linked list. It houses the methods used to
!   manipulate the linked list
!------------------------------------------------------------

module EmployeeModule
    implicit none
    type Employee                                           ! Custom type Employee, creates the linked list
        integer id
        character(31) :: name
        character(31) :: deptName
        character(31) :: position
        real salary
        type(Employee), pointer :: next => null()
    end type Employee

    contains
    subroutine printData(emp)                               ! Prints the data for a given Employee
        type(Employee), pointer :: emp
        if (associated(emp)) then                           ! Perform null pointer check
            write(1,*), emp%name, " (", emp%id, ")"
            write(1,*), "Department: ",emp%deptName
            write(1,*), "Position: ", emp%position
            write(1,"(A8 F8.2)"), "Salary: ", emp%salary
        end if
    end subroutine printData

    subroutine printAllEmps(head)                           ! Traverses the linked list and prints all Employees
        type(Employee), pointer :: head
        type(Employee), pointer :: current
        allocate(current, source=head%next)
        write(1,*), "All Employees:"
        do while(associated(current))
            call printData(current)
            current => current%next
        end do
        write(1,*), "All Employees Displayed."
    end subroutine printAllEmps

    subroutine insert(head, emp)                            ! Inserts a new Employee into the ascending-ordered linked list
        type(Employee), pointer :: head
        type(Employee), pointer :: emp
        type(Employee), pointer :: current
        type(Employee), pointer :: previous
        type(Employee), pointer :: temp
        current => head
        write(1,*), "Inserting employee ", emp%id
        do while ( current%id < emp%id )                    ! Goes while the new Employee's ID is greater than the current node
            if ( associated(current%next) ) then
                previous => current
                current => current%next
            else
                current%next => emp
                return
            end if
        end do
        emp%next => current;                                ! Performs the insertion
        previous%next => emp
    end subroutine insert

    subroutine delete(head, i)                              ! Deletes an Employee from the linked list
        type(Employee), pointer :: head
        type(Employee), pointer :: current
        type(Employee), pointer :: previous
        integer :: i
        current => head
        previous => head
        do while ( associated(current%next) )
            if (current%id == i) then 
                previous%next => current%next               ! Link around the Employee to be deleted
                deallocate(current)                         ! Free current's memory
                return
            end if
            previous => current                             ! Keep a record of the previous node
            current => current%next                         ! Advance the iteration
        end do

        if(.not.associated(current%next) ) then             ! Informs the user if an invalid ID was given
            write(1,*) "Could not find employee ", i
        end if
    end subroutine delete

    subroutine updateLN(head, i, last)                      ! Updates the Employee's last name
        type(Employee), pointer :: head
        type(Employee), pointer :: current
        integer :: i
        character(12) :: last
        current => findById(head, i)                        ! Gets the Employee by ID
        if (associated(current)) current%name = last        ! Update the last name
    end subroutine updateLN

    subroutine updateTitle(head, i, title)                  ! Update the Employee's title
        type(Employee), pointer :: head
        type(Employee), pointer :: current
        integer :: i
        character(12) :: title
        current => findById(head, i)                        ! Gets the Employee by ID
        if (associated(current)) then
            current%position = title                        ! Update the title
        end if
    end subroutine updateTitle

    subroutine updateDept(head, i, dept)                    ! Updates the Employee's Department
        type(Employee), pointer :: head
        type(Employee), pointer :: current
        integer :: i
        character(23) :: dept
        current => findById(head, i)                        ! Gets the Employee by ID
        if (associated(current)) current%deptName = dept    ! Updates the department
    end subroutine updateDept

    subroutine updatePay(head, i, pay)                      ! Updates the Employee's salary
        type(Employee), pointer :: head
        type(Employee), pointer :: current
        integer :: i
        real :: pay
        current => findById(head, i);                       ! Gets the Employee by ID
        if (associated(current)) current%salary = pay       ! Updates the salary
    end subroutine updatePay

    subroutine printDept(head, dept)                        ! Traverses the list and prints all employees in a given department
        type(Employee), pointer :: head
        type(Employee), pointer :: current
        character(12) :: dept
        current => head
        do while(associated(current%next))
            if (current%deptName .eq. dept) then
                call printData(current)
            end if
            current => current%next
        end do
    end subroutine printDept

    function findById(head, id) result (emp)                ! Finds and returns an Employee by ID
        type(Employee), pointer :: head
        type(Employee), pointer :: emp
        type(Employee), pointer :: current
        integer id
        current => head
        do while (current%id < id)                          ! Traverses the linked list while ID is less than the specified ID
            if (associated(current%next)) then              ! Acts much like a iterative search
                current => current%next
            else
                write(1,*), "Cannot find employee ", id
                nullify(emp)
                return
            end if
        end do
        if (current%id == id) then
            emp => current
            return
        else
            write(1,*), "Cannot find employee ", id
            nullify(emp)
        end if
    end function findById

end module EmployeeModule
