package com.microservice.estoqueconsumer.consumer;

import constants.RabbitmqConstants;
import dto.PrecoDto;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class PrecoConsumer {

    @RabbitListener(queues = RabbitmqConstants.FILA_PRECO)
    private void consumidor(PrecoDto precoDto){
        System.out.println("Preço Mensagem -");
        System.out.println(precoDto.codProduto);
        System.out.println(precoDto.preco);
        System.out.println("______________________");
    }
}
