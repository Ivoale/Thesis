function count = find_1(result,del_1,del_2)

%Find the number os sample points being classified as no touch type

count = 0;
for j = 1:16
for i = del_1:del_2;
    if result(j,i) == 1
        count = count +1;
    end
    
end
end
end