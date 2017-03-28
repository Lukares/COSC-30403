import 'dart:io';
import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'dart:collection';

void main()
	{
		print("Initializing the employee linked list . . .\n");
		Lab5 main = new Lab5();
	}

class Employee 
	{
		String name, deptName, title;
		int id;
		double salary; 
		Employee next;
	}
class Lab5
{
	String cmd;
	var employeeLL;
	Employee listHead = new Employee();
	Employee curr;
	Employee prev;

	Lab5()
	{
		listHead.name = "Head";
		listHead.next = null; 
		listHead.id = 00000000;
		var inputFile = new File("Lab4Data.txt");
		import(inputFile);	

	}

	void import(File i)  
	{
	  Stream<List<int>> inputStream = i.openRead();

	  inputStream
	    .transform(UTF8.decoder)       
	    .transform(new LineSplitter()) 
	    .listen((String line) { 
	    	cmd = line.substring(0, 2);
	    	Employee temp = new Employee();
	    	switch (cmd)
	    	{
	    		case 'IN':
	    			temp.id = (int.parse(line.substring(3, 11)));   
	    			temp.name = line.substring(12,24);
	    			temp.deptName = line.substring(24,40);
	    			temp.title = line.substring(40,58);
	    			temp.salary = double.parse(line.substring(58,63));

	    			insert(temp);

	    			break;
	    		case 'PA':
	    			printAll();
	    			break;
	    		case 'PI':
	    			int id = int.parse(line.substring(3, 11)); 
	    			printEmployee(id);
	    			break;
	    		case 'DE':
	    			int id = int.parse(line.substring(3, 11)); 
	    			delete(id);
	    			break;

	    		case 'UN':
	    			int id = int.parse(line.substring(3, 11));
	    			updateName(id, line.substring(line.length - 7));
	    			break;

	    		case 'UD':
					int id = int.parse(line.substring(3, 11));
	    			updateDept(id, line.substring(line.length - 14));	    		
	    			break;

	    		case 'UT':
					int id = int.parse(line.substring(3, 11));
	    			updateTitle(id, line.substring(40,54));
	    			break;

	    		case 'UR':
	    			int id = int.parse(line.substring(3, 11));
	    			updateSalary(id, double.parse(line.substring(line.length - 5)));
	    			break;
	    	}
	        
	      },
	      onDone: () 
	      	{ 
	    	  	print('File is now closed.'); 
	      	},
	      onError: (e) 
	      	{ 
	      		print(e.toString()); 
	      	});
	}

	void insert(Employee node)
	{
		print("Inserting employee with id: ${node.id} into the Linked List. . . \n");
		if(listHead.next == null) 
		{
			listHead.next = node; 
			node.next = null;
			return;
		}
		else
		{
			curr = listHead.next;
			prev = listHead;
			while(curr.next != null)
			{
				if(curr.id >= node.id)
				{
					prev.next = node;
					node.next = curr;
					return;
				}

				prev = curr;
				curr = curr.next;
			}
			curr.next = node;
			node.next = null;
			
		}
	}
	void delete(int x)
	{
		print("Deleting employee with id: $x . . .");
		curr = listHead.next;
		prev = listHead;
		while(curr.id != x)
		{
			if(curr.next == null)
			{
				print("Could not delete employee: $x \n");
				return;
			}
			prev = curr;
			curr = curr.next;
		}
		prev.next = curr.next;
		curr.next = null;
		print("Deleted employee with id: $x \n");
	}
	void printAll()
	{
		print("Displaying all current employee entries . . .\n");
		curr = listHead.next;
		while(curr != null)
			{
				print("${curr.id} \t ${curr.name} \t ${curr.deptName} \t ${curr.title} \t ${curr.salary}");
				curr = curr.next;
			}	
		print("\n");
	}
	void printEmployee(int x)
	{
		print("Searching for current employee with id: $x . . .");
		curr = listHead.next;
		while(curr.id != x)
		{
			if(curr.next == null)
			{
				print("Could not find employee: $x \n");
				return;
			}
			curr = curr.next;
		}
		print("Employee with id: $x found! Displaying . . .");
		print("${curr.id} \t ${curr.name} \t ${curr.deptName} \t ${curr.title} \t ${curr.salary}\n");
	}
	void updateName(int id, String newName)
	{
		print("Updating name of employee with id: $id to $newName . . .\n");
		curr = listHead.next;
		while(curr.id != id)
		{
			if(curr.next == null)
			{
				print("Could not find employee: $id \n");
				return;
			}
			curr = curr.next;
		}	
		
		curr.name = newName;	
	}
	void updateDept(int id, String newDept)
	{
		print("Updating department of employee with id: $id to $newDept . . .\n");
		curr = listHead.next;
		while(curr.id != id)
		{
			if(curr.next == null)
			{
				print("Could not find employee: $id \n");
				return;
			}
			curr = curr.next;
		}	
		
		curr.deptName = newDept;	
	}
	void updateTitle(int id, String newTitle)
	{
		print("Updating title of employee with id: $id to $newTitle . . .\n");
		curr = listHead.next;
		while(curr.id != id)
		{
			if(curr.next == null)
			{
				print("Could not find employee: $id \n");
				return;
			}
			curr = curr.next;
		}	
		
		curr.title = newTitle;	
	}
	void updateSalary(int id, double newSalary)
	{
		print("Updating salary of employee with id: $id to $newSalary . . .\n");
		curr = listHead.next;
		while(curr.id != id)
		{
			if(curr.next == null)
			{
				print("Could not find employee: $id \n");
				return;
			}
			curr = curr.next;
		}	
		
		curr.salary = newSalary;	
	}
}


