with Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Text_IO, Ada.Float_Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Emp is
  head : Node := new Employee;
  outFile : File_Type;
  procedure init is
    begin
      Open(File => outFile, Mode => Out_File, Name => "Lab3Results.txt");
      head.name := To_Unbounded_String("HEAD");
      head.ID := -1;
      head.next := null;
    end init;
  procedure addEmployee(emp : Node) is
    current : Node := head;
  begin
    while current.next /= null loop
      if current.next.ID < emp.ID then
        current := current.next;
      else
        exit;
      end if;
    end loop;
    if current.next /= null then
      emp.next := current.next;
    end if;
    current.next := emp;
  end addEmployee;
  procedure printEmpData(emp : Node) is
    line : Unbounded_String := To_Unbounded_String("");
    ids : Unbounded_String;
    ss: String(1..8);
  begin
    if emp = null then
    begin
      Put_Line(outFile, "Employee not found.");
      return;
    end;
    end if;
    Put_Line(outFile, "Printing information for Employee " & Integer'Image(emp.ID));
    ids := To_Unbounded_String(" (" & Integer'Image(emp.ID) & ")");
    Put(ss, emp.salary, 2, 0);
    line := emp.name & ids & " " & emp.deptName & " -> " & emp.title & " [$" & Trim(To_Unbounded_String(ss), Left) & "]";
    Put_Line(outFile, To_String(line));
  end printEmpData;

  procedure delete( id : Integer) is 

    curr : Node := head.next;
    prev : Node := head;

  begin
    Put_Line(outFile, "Deleting employee. . . ");

    while curr /= null loop
      if(curr.ID = id) then
      begin
        prev.next := curr.next;
        curr.next := null;
        exit;
      end;

      else
      begin
        prev := curr;
        curr := curr.next;
      end;
      end if;
    end loop;
    if curr = null then
      Put_Line(outFile, "Could not find employee");
    end if;
  end delete;

  procedure printAllEmployees is
    current : Node := head.next;
  begin
    Put_Line(outFile, "Printing all Employees...");
    while current /= null loop
      printEmpData(current);
      current := current.next;
    end loop;
    Put_Line(outFile, "All Employees displayed");
  end printAllEmployees;
  procedure printDept(dept : String) is
    current : Node := head.next;
  begin
    Put_Line(outFile, "Printing all Employees in " & dept);
    while current /= null loop
      if Trim(current.deptName, Right) = dept then
        printEmpData(current);
      end if;
      current := current.next;
    end loop;
    Put_Line(outFile, "All Employees in " & dept & " displayed");
  end printDept;

  procedure updateName(id : Integer; newName : Unbounded_String) is
  begin
    Put_Line(outFile, "Updating name . . .");
    findByID(id).name := newName;
  end updateName;

  procedure updateDept(id : Integer; newDept : Unbounded_String) is
  begin      
    Put_Line(outFile, "Updating department for employee . . .");
    findByID(id).deptName := newDept;
  end updateDept;

  procedure updateRate(id : Integer; newRate : float) is
  begin 
    Put_Line(outFile, "Updating pay rate for employee . . .");
    findByID(id).salary := newRate;
  end updateRate;

  procedure updateTitle(id : Integer; newTitle : Unbounded_String) is
  begin
    Put_Line(outFile, "Updating title for employee . . .");
    findByID(id).title := newTitle;
  end updateTitle;

  function findByID(id : Integer) return Node is
    current : Node := head;
  begin
    while current /= null loop
      if current.ID < id then
        current := current.next;
      else
        exit;
      end if;
    end loop;
    if current.ID = id then
      return current;
    end if;
    return null;
  end findByID;
begin
  null;
end Emp;