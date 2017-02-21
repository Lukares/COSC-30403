unit EmployeeModule;

interface
uses sysutils;

type Node = ^Employee;
    Employee = record
        surname, deptName, title : String;
        ID : longint;
        salary : Real;
        next : Node;
    end;

procedure init();
procedure addEmployee(emp : Node);
procedure printAllEmployees();
procedure printEmpData(emp : Node);
procedure printEmployeesByDept(dept : String);
function getEmployeeByID(ID : LongInt) : Node;
function deleteEmployeeByID(ID : LongInt) : LongInt;

var
    head : Node;
    outFile : TextFile;

implementation

procedure init();
begin
    assign(outFile, 'Lab2Ans.txt');
    rewrite(outFile);
    new(head);
    head^.next := nil;
end;

procedure addEmployee(emp : Node);
var
    current : Node;
begin
    WriteLn('Inserting Employee ' + IntToStr(emp^.ID));
    WriteLn(outFile, 'Inserting Employee ' + IntToStr(emp^.ID));
    if head = nil then
    begin
        head := emp;
        exit;
    end;
    current := head;
    while current^.next <> nil do
    begin
        if emp^.ID > current^.next^.ID then
        begin
            current := current^.next;
        end else
        begin
            break;
        end;
    end;
if current^.next <> nil then
    begin
        emp^.next := current^.next;
    end;
        current^.next := emp;
end;

procedure printAllEmployees();
var
    current : Node;
begin
    WriteLn('Printing All Employees...');
    WriteLn(outFile, 'Printing All Employees...');
    current := head^.next;
    while current <> nil do
    begin
        printEmpData(current);
        current := current^.next;
    end;
    WriteLn('All Employees Displayed');
    WriteLn(outFile, 'All Employees Displayed');
end;

procedure printEmpData(emp : Node);
var
    line : String;
begin
    line := '';
    line := line + emp^.surname;
    line := line + ' (' + IntToStr(emp^.ID) + ')';
    WriteLn(line);
    WriteLn(outFile, line);
    WriteLn(emp^.deptName);
    WriteLn(outFile, emp^.deptName);
    WriteLn(emp^.title);
    WriteLn(outFile, emp^.title);
    WriteLn(emp^.salary:5:2);
    WriteLn(outFile, emp^.salary:5:2);
end;

procedure printEmployeesByDept(dept : String);
var
    current : Node;
begin
    current := head;
    WriteLn('Printing Employees in Department: ' + dept);
    WriteLn(outFile, 'Printing Employees in Department: ' + dept);
    while current <> nil do
    begin
        if Trim(current^.deptName) = Trim(dept) then
        begin
            printEmpData(current);
        end;
        current := current^.next;
    end;
    WriteLn('All Employees in: ' + dept + ', Displayed');
    WriteLn(outFile, 'All Employees in: ' + dept + ', Displayed');
end;

function getEmployeeById(ID : longint) : Node;
var
    current : Node;
begin
    current := head;
    while current <> nil do
    begin
        if current^.ID = ID then
        begin
            exit(current);
        end;
        current := current^.next;
    end;
    exit(nil);
end;

function deleteEmployeeByID(ID: LongInt) : LongInt;
var
    current , previous : Node;
begin
    current := head;
    previous := nil;
    while current <> nil do
    begin
        if current^.ID = ID then
        begin
            if (current = head) then
            begin
                head := current^.next;
                exit(1);
            end;
            previous^.next := current^.next;
            exit(1);
        end;
        previous := current;
        current := current^.next;
    end;
    exit(0);
end;

end.
