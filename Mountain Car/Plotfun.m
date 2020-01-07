set(0, 'DefaultFigureRenderer', 'painters')
for j = 1 : length(Pr)
    name = sprintf('data%d',j);
    load(name);
    for i = 1 : 100
        if sum(Pr(j).A)/length(Pr(j).A) > 0.5
            T = 1;
        else
            T = 0;
        end
        if Pr(j).A(i) == T
            g = plot(data(i).xpos, data(i).vel, '.g','MarkerSize',4);
            hold on
        else
            r = plot(data(i).xpos, data(i).vel, '.r', 'MarkerSize',4);
            hold on
        end
    end
end
xlim([-1.2,0.5])
ylim([-1,1])
xlabel('$X$','Interpreter','latex')
ylabel('$\nu$','Interpreter','latex')
legend([g;r], {'Satisfaction of $\dimond_{[0,\delta]}(x>0.6)$','Violation of $\dimond_{[0,\delta]}(x>0.6)$'},'Interpreter','latex');
set(gca,'fontname','times','FontSize',20);
set(gcf, 'PaperUnits', 'inches');
x_width=7.25 ;y_width=7.25;
set(gcf, 'PaperPosition', [0 0 x_width y_width]); %
