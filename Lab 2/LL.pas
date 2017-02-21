program LL;
uses sysutils;
type nodePtr = ^Node;
    Node = record
        value : longint;
        next : nodePtr;
    end;
var
    head, tmp : nodePtr;
    i : longint;
procedure add(p : nodePtr);
var
    current : nodePtr;
begin
    if head = nil then
    begin
        head := p;
        exit;
    end;
    current := head;
    while current^.next <> nil do
    begin
        current := current^.next;
    end;
    current^.next := p;
end;
procedure display();
var
    current : nodePtr;
begin
    current := head;
    while current <> nil do
    begin
        WriteLn(current^.value);
        current := current^.next;
    end;

end;
begin
    i := 0;
    new(head);
    head^.value := -1;
    head^.next := nil;
    for i:=1 to 10 do
    begin
        new(tmp);
        tmp^.value := i;
        tmp^.next := nil;
        add(tmp);
    end;
    display();
end.
