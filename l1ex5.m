% Encontre a raiz de 𝑓(𝑥) = 𝑥4 − 8𝑥3 + 23𝑥2 + 16𝑥 − 50 no intervalo 1,0 ≤ 𝑥 ≤ 2,0 utilizando o Método da Bissecção com, no máximo, 1000 iterações. 
% Quantas iterações foram necessárias até a convergência? Resposta: 1,4142 para uma tolerância de 10−5.

function l1ex5()
    clc;
    iteracoes = 1000;
    contador = 1;
    tolerancia = 1e-5;
    erro = NaN;
    xl = 1.0;
    xu = 2.0;
    xrantigo = NaN;
    [xr, xhistorico, yhistorico] = bisseccao(xl, xu, xrantigo, tolerancia, iteracoes);
    figure(1); grafico_rosa(xhistorico, yhistorico, xl, xu);
    figure(2); convergenciaxr(xhistorico, yhistorico);
    figure(3); convergenciafxr(xhistorico, yhistorico)
    fprintf('A raix de 𝑓(𝑥) = 𝑥^4 − 8𝑥^3 + 23𝑥^2 + 16𝑥 − 50 no intervalo 1,0 ≤ 𝑥 ≤ 2,0 utilizando o Método da Bissecção é %.6f, e %i iterações foram suficientes.', xr, size(xhistorico,1))
endfunction

function [xr, xhistorico, yhistorico] = bisseccao(xl, xu, xrantigo, tolerancia, iteracoes)
    % Verificar se há troca de sinal entre intervalo
    mul = problema(xl) * problema(xu);
    xhistorico = zeros(iteracoes,1);
    yhistorico = zeros(iteracoes,1);
    if mul > 0
        error('Não há raiz nesse intervalo')
        endif
    for contador = 0:iteracoes  
        % Tentar achar raiz no intervalo
        xr = (xl + xu) / 2;
        xhistorico(contador+1) =  xr;
        yhistorico(contador+1) =  problema(xr);
        erro = abs(xrantigo-xr);
        % Achar metade
        if (problema(xl) * problema(xr)) < 0
            % Ta na primeira metade
            xu = xr;
        elseif (problema(xl) * problema(xr)) > 0
            % Ta na segunda metade
            xl = xr;
        endif
        if abs(xrantigo - xr) <= tolerancia
            break;
        endif
        xrantigo = xr; 
    endfor
    % Cortando tudo zerado no vetor
    xhistorico = xhistorico(1:contador);
    yhistorico = yhistorico(1:contador);
    endfunction

    function y = problema(x)
    y = (x^4) - (8*x^3) + (23*x^2) + (16*x) - 50;
endfunction

function grafico_rosa(xhistorico, yhistorico, xl, xu)
    % Intervalo definido
    intervalo = xl:0.1:xu;
    y = zeros(size(intervalo));
    i = 1;
    for xx = intervalo
        y(i) = problema(xx);;
        i = i + 1;
    endfor
    iteracoes = size(yhistorico, 1);  
    for ciclos = 1:iteracoes
        plot(intervalo, y, 'linewidth', 4, 'color', [0.9922, 0.0000, 0.5490]);
        grid;
        title("y = (x^4) - (8*x^3) + (23*x^2) + (16*x) - 50", 'fontsize', 15);
        xlabel("Eixo X");
        ylabel("Eixo Y");
        hold on;
        plot(xhistorico(ciclos), yhistorico(ciclos), 'marker', 'o', 'markersize', 15, 'markerfacecolor', [0.9922, 0.0000, 0.5490], 'DisplayName', 'Ponto')
        text((xhistorico(ciclos)+ 0.05), (yhistorico(ciclos)), [num2str(xhistorico(ciclos)), ', ', num2str(yhistorico(ciclos))], 'Color', 'k', 'fontsize', 15);
        text(1.01, 28, sprintf('Iteração: %d', ciclos), 'FontSize', 15);
        flegend = legend('Função','XR', 'Location', 'northeast');
        set(flegend, 'FontSize', 15);
        pause(0.1);
        hold off;
    endfor
endfunction

function convergenciaxr(xhistorico, yhistorico) %Convergência pra xr e para f,xr,
    iteracoes = size(xhistorico, 1);
    plot(1:iteracoes, xhistorico, 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4);
    title("Convergência do Metodo da Bissecção em Relacao ao xr")
    xlabel("Iteracoes");
    ylabel("xr");
endfunction

function convergenciafxr(xhistorico, yhistorico) %Convergência pra xr e para f,xr,
    iteracoes = size(yhistorico, 1);
    plot(1:iteracoes, yhistorico, 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4);
    title("Convergência do Metodo da Bissecção em Relacao ao f(xr)")
    xlabel("Iteracoes");
    ylabel("f(xr)");
endfunction
