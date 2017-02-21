!------------------------------------------------------------
!>  Lab 1 - Linked List Management Program (Fortran)
!   Blake Lucas and Luke Reddick
!   COSC 30403-035
!   7 February 2017
!
!>  This program reads in a input text file and performs
!   operations--insert, delete, update, and print (in various
!   forms)--on a singly linked list sorted ascendingly by the
!   employee's ID number.
!------------------------------------------------------------

program Main
    use EmployeeModule
    implicit none

    ! Variable declarations
    INTEGER  :: openStat, lineStat , id, outStat    ! *Stat used for IO control, id for each command
    REAL     ::  pay                                ! Update salary variable
    CHARACTER(LEN=23) :: en, dn, ln, jt             ! Variable parameter strings
    CHARACTER(LEN=2) :: cmd                         ! String for each command
    CHARACTER(63) :: line                           ! String for each new line in the file
    type(Employee), pointer :: listHead             ! Pointer for the linked list header
    type(Employee), pointer :: n                    ! Pointer for a new employee
    character(32), dimension(5) :: parts            ! Array for the split line on insert

    ! Allocate the list header
    allocate(listHead)
        listHead%name = "HEADER"
        listHead%id = -1                            ! -1 so it will always be first in the ordered linked list.
        listHead%deptName = "HEADER"
        listHead%position = "HEADER"
        listHead%salary = -1.00
        nullify(listHead%next)

    ! Open Lab1Ans file for the output
    open(unit=1, file="./Lab1Ans.txt", iostat=outStat)
    ! Check to ensure the open was successful.
    if (outStat .ne. 0) write(*,*) "Error opening output file."
    ! Open the Lab1Data input file
    OPEN( unit=2 , file="./Lab1Data.txt", iostat=openStat)
    ! Check to ensure the open was successful.
    if (openStat /= 0) WRITE(*,*) "File cannot be opened"
    do
        ! Read each line from file
        READ(2,'(A63)', iostat=lineStat) line
        if (lineStat < 0) then
            CLOSE(2)
            call printAllEmps(listHead)             ! Print all employess on EOF.
            exit
        end if

        READ(line, '(A2, 1X)') cmd                  ! Read the line's command and switch
        select case (cmd)
            case ("IN")
                read(line, '(A63)')
                parts = splitParts(line)            ! Get all parts of each line
                allocate(n)                         ! Allocate a new node for the new Employee
                    n%name = parts(2)
                    read(parts(1), '(i32)') n%id
                    n%deptName = parts(3)
                    n%position = parts(4)
                    read(parts(5), '(F31.2)') n%salary
                    call insert(listHead, n)        ! Insert the new Employee
            case ("DE")
                read(line, '(3X, I8)') id           ! Read the ID
                write(1,*), "Deleting employee ", id
                call delete(listHead, id)           ! Delete Employee with the corresponding ID
            case ("UN")
                read(line, '(3X, I8, 29X, A12)') id, ln     ! Read the ID and new last name
                write(1,*), "Updating employee last name . . ."
                call updateLN(listHead, id, ln)     ! Update the specified Employee's last name
            case ("UT")
                read(line, '(3X, I8, 29X, A12)') id, jt ! Read the ID and new title
                write(1,*), "Updating employee job title . . ."
                call updateTitle(listHead, id, jt)  ! Update the specified Employee's title
            case ("UR")
                read(line, '(3X, I8, 31X, F7.2)') id, pay   ! Read the ID and the new salary
                write(1,*), "Updating employee salary . . ."
                call updatePay(listHead, id, pay)   ! Update the specified Employee's salary
            case ("UD")
                read(line, '(3X, I8, 29X, A23)') id, dn     ! Read the ID and new department
                write(1,*), "Updating employee department name . . ."
                call updateDept(listHead, id, dn)   ! Update the specified Employee's department
            case ("PA")
                call printAllEmps(listHead)         ! Print all Employees
            case ("PI")
                read(line, '(3X, I8)') id           ! Read the ID
                write(1,*), "Printing information for ", id
                call printData(findById(listHead, id))      ! Print the data for the corresponding Employee, if available
            case ("PD")
                read(line, '(3X, A12)') dn          ! Read the department name
                write(1,*), "Displaying all employees in ", dn
                call printDept(listHead, dn)        ! Print all Employees in the department
                write(1,*), "All employees in ",dn, " displayed"
        END SELECT
    END DO
    close(1)                                        ! Close the output file

    contains
    function splitParts(line) result(parts)         ! Substrings each line into a length 5 array
        character(63) :: line
        character(31), dimension(5) :: parts
        parts(1) = line(4:11)                       ! ID
        parts(2) = line(13:24)                      ! Name
        parts(3) = line(25:40)                      ! Department
        parts(4) = line(41:58)                      ! Position
        parts(5) = line(58:63)                      ! Salary
    end function splitParts
end program Main
