function plotted = plot_threshold(newtarget,normli,DoSaveFile)
%Plot the threshold over the first touch type

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,1)
plot(normli(1:1000,1))
hold on
plot(newtarget(:,1));
title('Threshold 1');
xlabel('Data Points');

subplot(3,4,2)
plot(normli(1:1000,2))
hold on
plot(newtarget(:,2));
title('Threshold 2');
xlabel('Data Points');

subplot(3,4,3)
plot(normli(1:1000,3))
hold on
plot(newtarget(:,3));
title('Threshold 3');
xlabel('Data Points');

subplot(3,4,4)
plot(normli(1:1000,4))
hold on
plot(newtarget(:,4));
title('Threshold 4');
xlabel('Data Points');

subplot(3,4,5)
plot(normli(1:1000,5))
hold on
plot(newtarget(:,5));
title('Threshold 5');
xlabel('Data Points');

subplot(3,4,6)
plot(normli(1:1000,6))
hold on
plot(newtarget(:,6));
title('Threshold 6');
xlabel('Data Points');

subplot(3,4,7)
plot(normli(1:1000,7))
hold on
plot(newtarget(:,7));
title('Threshold 7');
xlabel('Data Points');

subplot(3,4,8)
plot(normli(1:1000,8))
hold on
plot(newtarget(:,8));
title('Threshold 8');
xlabel('Data Points');

subplot(3,4,9)
plot(normli(1:1000,9))
hold on
plot(newtarget(:,9));
title('Threshold 9');
xlabel('Data Points');

subplot(3,4,10)
plot(normli(1:1000,10))
hold on
plot(newtarget(:,10));
title('Threshold 10');
xlabel('Data Points');

subplot(3,4,11)
plot(normli(1:1000,11))
hold on
plot(newtarget(:,11));
title('Threshold 11');
xlabel('Data Points');

subplot(3,4,12)
plot(normli(1:1000,12))
hold on
plot(newtarget(:,12));
title('Threshold 12');
xlabel('Data Points');

if DoSaveFile == 1
    saveas(gcf,'Threshold.jpg')
end


end