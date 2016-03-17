% Save Open Figure Windows


saveme = input('Save figures?','s');
switch saveme
    case {'Y','YES','y','yes'}
        mkdir png;
        mkdir fig;
        mkdir pdf;
        h = get(0,'children');
        sort(h);
        for i = 1:length(h)
            saveas(h(i),['fig/figure' num2str(get(h(i),'Number'))],'fig')
            saveas(h(i),['pdf/figure' num2str(get(h(i),'Number'))],'pdf')
            saveas(h(i),['png/figure' num2str(get(h(i),'Number'))],'png')
        end
    %             saveas(h(i), get(h(i),'Name'), 'fig');
end