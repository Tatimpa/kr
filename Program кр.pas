program VectorObjects;

type
  TVec3 = object
  private
    x, y, z: real;
    length: real;
  public
    constructor Init(ax, ay, az: real);
    procedure CalculateLength();
    procedure Print();
    function GetLength(): real;
    procedure SetVector(ax, ay, az: real);
  end;

  PContainer = ^TContainer;
  TContainer = object
  private
    data: array of TVec3;
  public
    constructor CreateRandom(n: integer);
    procedure PrintAllVectors();
    procedure AddVector(v: TVec3);
    function FindShortestVector(): TVec3;
  end;

constructor TVec3.Init(ax, ay, az: real);
begin
  x := ax;
  y := ay;
  z := az;
  CalculateLength();
end;

procedure TVec3.CalculateLength();
begin
  length := sqrt(x * x + y * y + z * z);
end;

procedure TVec3.Print();
begin
  writeln('Vector x = ', x:0:2, ' y = ', y:0:2, ' z = ', z:0:2, ' length = ', length:0:2);
end;

function TVec3.GetLength(): real;
begin
  GetLength := length;
end;

procedure TVec3.SetVector(ax, ay, az: real);
begin
  x := ax;
  y := ay;
  z := az;
  CalculateLength();
end;

constructor TContainer.CreateRandom(n: integer);
var
  i: integer;
begin
  Randomize();
  SetLength(data, n);
  for i := Low(data) to High(data) do
    data[i].SetVector(Random(10), Random(10), Random(10));
end;

procedure TContainer.PrintAllVectors();
var
  i: integer;
begin
  for i := Low(data) to High(data) do
    data[i].Print();
end;

procedure TContainer.AddVector(v: TVec3);
begin
  SetLength(data, Length(data) + 1);
  data[High(data)] := v;
end;

function TContainer.FindShortestVector(): TVec3;
var
  i: integer;
  shortest: TVec3;
begin
  shortest := data[Low(data)];
  for i := Low(data) + 1 to High(data) do
    if data[i].GetLength() < shortest.GetLength() then
      shortest := data[i];
  FindShortestVector := shortest;
end;

var
  container: TContainer;
  v1, v2, v3: TVec3;
begin
  container.CreateRandom(5);

  v1.Init(1, 2, 3);
  v2.Init(0, 1, 2);
  v3.Init(2, 4, 6);
  container.AddVector(v1);
  container.AddVector(v2);
  container.AddVector(v3);

  writeln('All vectors:');
  container.PrintAllVectors();

  writeln('Shortest vector:');
  container.FindShortestVector().Print();

  readln;
end.