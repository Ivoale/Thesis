function plotted = plot_thresholdAll(newtarget,normli,DoSaveFile)
%Plot the threshold over the whole standard deviation profile

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,1)
plot(normli(:,1))
hold on
plot(newtarget(:,1));
title('Threshold over the profile 1');
xlabel('Data Points');

subplot(3,4,2)
plot(normli(:,2))
hold on
plot(newtarget(:,2));
title('Threshold over the profile 2');
xlabel('Data Points');

subplot(3,4,3)
plot(normli(:,3))
hold on
plot(newtarget(:,3));
title('Threshold over the profile 3');
xlabel('Data Points');

subplot(3,4,4)
plot(normli(:,4))
hold on
plot(newtarget(:,4));
title('Threshold over the profile 4');
xlabel('Data Points');

subplot(3,4,5)
plot(normli(:,5))
hold on
plot(newtarget(:,5));
title('Threshold over the profile 5');
xlabel('Data Points');

subplot(3,4,6)
plot(normli(:,6))
hold on
plot(newtarget(:,6));
title('Threshold over the profile 6');
xlabel('Data Points');

subplot(3,4,7)
plot(normli(:,7))
hold on
plot(newtarget(:,7));
title('Threshold over the profile 7');
xlabel('Data Points');

subplot(3,4,8)
plot(normli(:,8))
hold on
plot(newtarget(:,8));
title('Threshold over the profile 8');
xlabel('Data Points');

subplot(3,4,9)
plot(normli(:,9))
hold on
plot(newtarget(:,9));
title('Threshold over the profile 9');
xlabel('Data Points');

subplot(3,4,10)
plot(normli(:,10))
hold on
plot(newtarget(:,10));
title('Threshold over the profile 10');
xlabel('Data Points');

subplot(3,4,11)
plot(normli(:,11))
hold on
plot(newtarget(:,11));
title('Threshold over the profile 11');
xlabel('Data Points');

subplot(3,4,12)
plot(normli(:,12))
hold on
plot(newtarget(:,12));
title('Threshold over the profile 12');
xlabel('Data Points');

if DoSaveFile == 1
    saveas(gcf,'ThresholdAll.jpg')
end

end