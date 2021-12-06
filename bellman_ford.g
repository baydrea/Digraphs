LoadPackage("Digraphs");
bellmanford := function(digraph, source)
local distance, n, predecessor, i, inf, u, v, edge, w;
n := DigraphNrVertices(digraph);
#wouldn't  work for weighted digraphs
inf := n+1;
distance := List([1..n],x->0);
predecessor := List([1..n],x->0);
for i in DigraphVertices(digraph) do
  distance[i] := inf;
  predecessor[i] := 0;
od;
distance[source] := 0;
for i in [1..n-1] do
  for edge in DigraphEdges(digraph) do
    u := edge[1];
    v := edge[2];
    #only works for unweighted graphs, w needs to be changed into a variable
    w := 1;
    if distance[u] + w < distance[v] then
      distance[v] := distance[u] + w;
      predecessor[v] := u;
    fi;
  od;
od;
for edge in DigraphEdges(digraph) do
  u := edge[1];
  v := edge[2];
  #only works for unweighted graphs, w needs to be changed into a variable
  w := 1;
  if distance[u] + w < distance[v] then
    Print("Graph contains a negative-weight cycle"); 
  fi;
od;
for i in DigraphVertices(digraph) do
  if distance[i] >= inf then
    distance[i] := fail;
  fi;
  if predecessor[i] = 0 then
    predecessor[i] := fail;
  fi;
od; 
return [distance, predecessor];
end;

