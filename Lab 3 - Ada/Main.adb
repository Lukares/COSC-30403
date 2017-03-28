with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with GNAT.String_Split; use GNAT;
with Emp; use Emp;

procedure Main is
  cmd : String(1..2);
  line : Unbounded_String;
  inFile : File_Type;
  testEmp : Node;
  parts : String_Split.Slice_Set;
  i : Integer := -1;
begin
  init;
  Open(File => inFile, Mode => In_File, Name => "Lab3Data.txt");
  while not End_Of_File(inFile) loop
    line := To_Unbounded_String(Get_Line(inFile));
    String_Split.Create(S => parts, From => To_String(line), Separators => " ", Mode => String_Split.Multiple);
    cmd := String_Split.Slice(parts, 1);
    if cmd = "IN" then
      testEmp := new Employee;
      testEmp.name := To_Unbounded_String(String_Split.Slice(parts, 3));
      testEmp.deptName := To_Unbounded_String(String_Split.Slice(parts, 4));
      testEmp.title := To_Unbounded_String(String_Split.Slice(parts, 5));
      testEmp.ID := Integer'Value(String_Split.Slice(parts, 2));
      testEmp.salary := Float'Value(String_Split.Slice(parts, 6));
      testEmp.next := null;
      --Put_Line("HI " & To_String(testEmp.name));
      addEmployee(testEmp);
    elsif cmd = "DE" then
        delete(Integer'Value(String_Split.Slice(parts, 2)));
    elsif cmd = "PA" then
        printAllEmployees;
    elsif cmd = "PI" then
      i := Integer'Value(String_Split.Slice(parts, 2));
      testEmp := findByID(i);
      printEmpData(testEmp);
    elsif cmd = "PD" then
      printDept(String_Split.Slice(parts, 2));
      null;
    elsif cmd = "UN" then
      updateName(Integer'Value(String_Split.Slice(parts, 2)), To_Unbounded_String(String_Split.Slice(parts, 5)));
      null;
    elsif cmd = "UD" then
      updateDept(Integer'Value(String_Split.Slice(parts, 2)), To_Unbounded_String(String_Split.Slice(parts, 5)));
      null;
    elsif cmd = "UR" then
      updateRate(Integer'Value(String_Split.Slice(parts, 2)), Float'Value(String_Split.Slice(parts, 5)));
      null;
    elsif cmd = "UT" then
      updatetitle(Integer'Value(String_Split.Slice(parts, 2)), To_Unbounded_String(String_Split.Slice(parts, 5)));
      null;
    end if;
  end loop;

  Close(inFile);
end Main;