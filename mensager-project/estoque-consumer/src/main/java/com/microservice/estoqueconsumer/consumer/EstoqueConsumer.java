package com.microservice.estoqueconsumer.consumer;

import constants.RabbitmqConstants;
import dto.EstoqueDto;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class EstoqueConsumer {

    @RabbitListener(queues = RabbitmqConstants.FILA_ESTOQUE)
    private void consumidor(EstoqueDto estoqueDto){
        System.out.println("Estoque Mensagem -");
        System.out.println(estoqueDto.codProduto);
        System.out.println(estoqueDto.quantidade);
        System.out.println("______________________");
    }
}
