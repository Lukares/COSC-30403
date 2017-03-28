with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Emp is
  type Employee;
  type Node is access Employee;
  type Employee is
    record
      name, deptName, title : Unbounded_String;
      ID : Integer;
      salary : float;
      next : Node;
    end record;
  procedure init;
  procedure addEmployee(emp : Node);
  procedure printAllEmployees;
  procedure printEmpData(emp : Node);
  procedure printDept(dept : String);
  procedure updateName(id : Integer; newName : Unbounded_String);
  procedure updateDept(id : Integer; newDept : Unbounded_String);
  procedure updateRate(id : Integer; newRate : float);
  procedure updateTitle(id : Integer; newTitle : Unbounded_String);
  procedure delete(id : Integer);
  function findByID(id : Integer) return Node;
end Emp;