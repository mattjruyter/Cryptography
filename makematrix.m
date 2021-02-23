function r = makematrix(x,m)
x = x';
r = [];for i=1:m;r = [r;x(i:i+m-1)];end;
end