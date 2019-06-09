function plotted = plot_meanZscore(meanZscore,DoSaveFile)
% Plot the moving average of the z-scores of the 12 sensors on just one graph

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,4,1)
plot(meanZscore(:,1))
title('Mean Zscore sensor 1');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,2)
plot(meanZscore(:,2))
title('Mean Zscore sensor 2');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,3)
plot(meanZscore(:,3))
title('Mean Zscore sensor 3');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,4)
plot(meanZscore(:,4))
title('Mean Zscore sensor 4');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,5)
plot(meanZscore(:,5))
title('Mean Zscore sensor 5');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,6)
plot(meanZscore(:,6))
title('Mean Zscore sensor 6');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,7)
plot(meanZscore(:,7))
title('Mean Zscore sensor 7');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,8)
plot(meanZscore(:,8))
title('Mean Zscore sensor 8');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,9)
plot(meanZscore(:,9))
title('Mean Zscore sensor 9');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,10)
plot(meanZscore(:,10))
title('Mean Zscore sensor 10');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,11)
plot(meanZscore(:,11))
title('Mean Zscore sensor 11');
xlabel('Data Points');
ylabel('Pressure (Pa)');

subplot(3,4,12)
plot(meanZscore(:,12))
title('Mean Zscore sensor 12');
xlabel('Data Points');
ylabel('Pressure (Pa)');

if DoSaveFile == 1
    saveas(gcf,'MeanZscores.jpg')
end

end
