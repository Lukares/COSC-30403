module input
IMPLICIT NONE

	INTEGER  :: openStat, lineStat , id;
	REAL	::	day;
	CHARACTER(LEN=12) :: en, dn, jt;
	CHARACTER(LEN=2) :: cmd;
	CHARACTER(63) :: line;

	OPEN( unit=2 , file="./Lab1Data.txt", iostat=openStat);
	IF (openStat /= 0) WRITE(*,*) "File cannot be opened";
	DO
		READ(2,'(A63)', iostat=lineStat) line;
	
		IF (lineStat < 0) THEN
			CLOSE(2);
			PRINT*, "EOF";
			EXIT
		END IF
	
		READ(line, '(A2, 1X)') cmd;
		SELECT CASE (cmd)
			CASE ("IN")
				CALL insert(READ(line, '(A63)');
			CASE ("DE")
		END SELECT
	END DO

	SUBROUTINE insert_luke(data)
		IMPLICIT NONE
		CHARACTER(LEN=66) :: data;
		TYPE(Employee), pointer :: current, next;

		ALLOCATE(next);
		READ(data, 10) next%id, next%firstName, next%lastName, next%deptName, next%position, next%salary;
		10 FORMAT(3X, I8, X, A12, X, A11, 1X, A15, 1X, A15, 1X, F7.2);

		current%link => next;
		NULLIFY(next%link);
		current => next; 	
			
		RETURN;
	END SUBROUTINE insert_luke
				
END module input
