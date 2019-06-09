function count = find_2(result,del_1,del_2)

%Find the number os sample points being classified as flick touch type

count = 0;
for j = 1:16
for i = del_1:del_2;
    if result(j,i) == 2
        count = count +1;
    end
    
end
end
end