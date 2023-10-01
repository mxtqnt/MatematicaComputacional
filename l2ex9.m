function l2ex9()
    clc;
    x0 = [0.5; 1 ; 0];
    iteracoes = 1000;
    tolerancia = 1e-5;
    [iteracoesusadas, raizaproximada, vetorconvergenciax, vetorconvergenciay, vetorconvergenciaz, matrizconvergenciaf] = metodonewtonraphson(x0, iteracoes, tolerancia); 

    figure(1, 'name', 'Convergências a partir do Metodo de Newton-Raphson'); plotagem(vetorconvergenciax, vetorconvergenciay, vetorconvergenciaz, matrizconvergenciaf, iteracoesusadas);

    fprintf('O sistema: \n  |6x − 2y + 𝑒^z = 2 \n  |sin(x) − y + z = 0 \n  |sin(x) + 2y + 3z = 1\n Utilizando o Método de Newton-Raphson na vizinhança de 𝑥1 = 0,5, 𝑥2 = 1 e 𝑥3 = 0 e o máximo de 1000 iterações.')

    fprintf('\n Necessitou de %d iteracoes, e encontrou a raiz: x=%.4f, y=%.4f, z=%.4f ', iteracoesusadas, raizaproximada(1), raizaproximada(2), raizaproximada(end));
endfunction

function funcoes = sistema(x0)
    x = x0(1);
    y = x0(2);
    z = x0(end);
    funcoes = [(6*x)-(2*y)+exp(z)-2;
                sin(x)-y+z;
                sin(x)+(2*y)+(3*z)-1];
endfunction

function derivadas = derivadaSistema(x0)
    x = x0(1);
    y = x0(2);
    z = x0(end);
    derivadas = [ 6,      -2, exp(z); 
                cos(x), -1, 1;
                cos(x),  2, 3];
endfunction

function [i, x1, vetorconvergenciax, vetorconvergenciay, vetorconvergenciaz, matrizconvergenciaf] = metodonewtonraphson(x0, iteracoes, tolerancia)
    matrizconvergenciaf = zeros(iteracoes, 3);
    for i = 1:iteracoes
        x1 = x0 - inv(derivadaSistema(x0))*sistema(x0);
        vetorconvergenciax(i, 1) = x0(1); 
        vetorconvergenciay(i, 1) = x0(2); 
        vetorconvergenciaz(i, 1) = x0(end); 
        matrizconvergenciaf(i, :) = sistema(x0);
        if max(abs(x1-x0)) <= tolerancia
            break;
        endif
        x0 = x1;
    endfor
    matrizconvergenciaf= matrizconvergenciaf(1:i,:)
endfunction

function plotagem(vetorconvergenciax, vetorconvergenciay, vetorconvergenciaz, matrizconvergenciaf, iteracoes)
    subplot(231);
    plot(1:iteracoes, vetorconvergenciax, 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4);
    grid on;
    title("X")
    xlabel("Iteracoes");

    subplot(232);
    plot(1:iteracoes, vetorconvergenciay, 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4);
    grid on;
    title("Y")
    xlabel("Iteracoes");

    subplot(233);
    plot(1:iteracoes, vetorconvergenciaz, 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4);
    grid on;
    title("Z")
    xlabel("Iteracoes");

    subplot(234);
    plot(1:iteracoes, matrizconvergenciaf(1,:), 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4);
    grid on;
    title("F(X)")
    xlabel("Iteracoes");

    subplot(235);
    plot(1:iteracoes, matrizconvergenciaf(2,:), 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4);
    grid on;
    title("F(Y)")
    xlabel("Iteracoes");

    subplot(236);
    plot(1:iteracoes, matrizconvergenciaf(end,:), 'color', [0.9922, 0.0000, 0.5490], 'linewidth', 4);
    grid on;
    title("F(Z)")
    xlabel("Iteracoes");
endfunction