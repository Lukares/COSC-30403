program Main;
uses sysutils, EmployeeModule;
var
    inFile : TextFile;
    line, cmd, ids, delta : String;
    e : Node;
    id, ret : LongInt;
    sal : Real;

function employeeFromLine (s: String) : Node;
var
    nEmp : Node;
Begin
    new(nEmp);
    nEmp^.ID := StrToInt(copy(s, 0, 9));
    s := copy (s, 11, length(s));
    nEmp^.surname := copy (s, 0, 12);
    s := copy (s, 13, length(s));
    nEmp^.deptName := copy (s, 0, 16);
    s := copy (s, 17, length(s));
    nEmp^.title := copy (s, 0, 18);
    s := copy (s, 19, length(s));
    nEmp^.salary := StrToFloat(copy (s, 0, length(s)));
    nEmp^.next := nil;
    Exit(nEmp);
End;

begin
    init();
    assign(inFile, 'Lab2Data.txt');
    reset(inFile);
    while not eof(inFile) do
    begin
        readln(inFile, line);
        cmd := copy (line, 0, 2);
        line := copy(line, 3, Length(line));
        if cmd = 'IN' then
        begin
            addEmployee(employeeFromLine(line));
        end;
        if cmd = 'DE' then
        begin
            ret := -1;
            ids := copy(line, 0, 9);
            id := StrToInt(ids);
            WriteLn('Deleting Employee' + ids);
            WriteLn(outFile, 'Deleting Employee' + ids);
            ret := deleteEmployeeByID(id);
            if ret = 0 then
            begin
                WriteLn('Employee' + ids + ' not found');
                WriteLn(outFile, 'Employee' + ids + ' not found');
            end else
                WriteLn('Employee' + ids + ' deleted successfully');
                WriteLn(outFile, 'Employee' + ids + 'deleted successfully');
        end;
        if cmd = 'PA' then
        begin
            printAllEmployees();
        end;
        if cmd = 'PI' then
        begin
            ids := copy(line, 0, 9);
            id := StrToInt(ids);
            e := getEmployeeByID(id);
            WriteLn('Printing Employee' + ids);
            WriteLn(outFile, 'Printing Employee' + ids);
            if e = nil then
            begin
                WriteLn('Employee' + ids + ' not found');
                WriteLn(outFile, 'Employee' + ids + ' not found');
            end else
            begin
                printEmpData(e);
            end;
        end;
        if cmd = 'PD' then
        begin
            delta := Trim(copy(line, 1, 18));
            printEmployeesByDept(delta);
        end;
        if cmd = 'UN' then
        begin
            ids := copy(line, 0, 9);
            WriteLn('Updating Name for Employee' + ids);
            id := StrToInt(ids);
            delta := copy(line, 39, 54);
            e := getEmployeeByID(id);
            if e = nil then
            begin
                WriteLn('Employee' + ids + ' not found');
                WriteLn(outFile, 'Employee' + ids + ' not found');
            end else
            begin
                e^.surname := copy(delta, 0, 12);
            end;
        end;
        if cmd = 'UT' then
        begin
            ids := copy(line, 0, 9);
            WriteLn('Updating Title for Employee' + ids);
            id := StrToInt(ids);
            delta := copy(line, 39, 54);
            e := getEmployeeByID(id);
            if e = nil then
            begin
                WriteLn('Employee' + ids + ' not found');
                WriteLn(outFile, 'Employee' + ids + ' not found');
            end else
            begin
                e^.title := copy(delta, 0, 16);
            end;
        end;
        if cmd = 'UD' then
        begin
            ids := copy(line, 0, 9);
            WriteLn('Updating Department for Employee' + ids);
            id := StrToInt(ids);
            delta := copy(line, 39, 54);
            e := getEmployeeByID(id);
            if e = nil then
            begin
                WriteLn('Employee' + ids + ' not found');
                WriteLn(outFile, 'Employee' + ids + ' not found');
            end else
            begin
                e^.deptName := delta;
            end;
        end;
        if cmd = 'UR' then
        begin
            ids := copy(line, 0, 9);
            WriteLn('Updating Pay Rate for Employee' + ids);
            id := StrToInt(ids);
            sal := StrToFloat(Trim(copy(line, 39, 54)));
            e := getEmployeeByID(id);
            if e = nil then
            begin
                WriteLn('Employee' + ids + ' not found');
                WriteLn(outFile, 'Employee' + ids + ' not found');
            end else
            begin
                e^.salary := sal;
            end;
        end;
    end;

    Close(inFile);

end.