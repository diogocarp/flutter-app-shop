package com.microservice.estoqueconsumer.config;

import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer;
import org.springframework.amqp.rabbit.listener.adapter.MessageListenerAdapter;
import org.springframework.amqp.support.converter.SimpleMessageConverter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.microservice.estoqueconsumer.consumer.EstoqueConsumer;
import com.microservice.estoqueconsumer.consumer.PrecoConsumer;
import constants.RabbitmqConstants;

import java.util.List;

@Configuration
@EnableRabbit
public class RabbitConfig {

    @Bean
    public SimpleMessageConverter messageConverter() {
        SimpleMessageConverter converter = new SimpleMessageConverter();
        converter.setAllowedListPatterns(List.of("dto.*"));
        return converter;
    }

    @Bean
    public RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory) {
        RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
        rabbitTemplate.setMessageConverter(messageConverter());
        return rabbitTemplate;
    }


    @Bean
    public SimpleMessageListenerContainer estoqueListenerContainer(ConnectionFactory connectionFactory,
                                                                   MessageListenerAdapter estoqueListenerAdapter) {
        SimpleMessageListenerContainer container = new SimpleMessageListenerContainer();
        container.setConnectionFactory(connectionFactory);
        container.setQueueNames(RabbitmqConstants.FILA_ESTOQUE);
        container.setMessageListener(estoqueListenerAdapter);
        return container;
    }

    @Bean
    public MessageListenerAdapter estoqueListenerAdapter(EstoqueConsumer consumidor) {
        MessageListenerAdapter adapter = new MessageListenerAdapter(consumidor, "consumidor");
        adapter.setMessageConverter(messageConverter());
        return adapter;
    }


    @Bean
    public SimpleMessageListenerContainer precoListenerContainer(ConnectionFactory connectionFactory,
                                                                 MessageListenerAdapter precoListenerAdapter) {
        SimpleMessageListenerContainer container = new SimpleMessageListenerContainer();
        container.setConnectionFactory(connectionFactory);
        container.setQueueNames(RabbitmqConstants.FILA_PRECO);
        container.setMessageListener(precoListenerAdapter);
        return container;
    }

    @Bean
    public MessageListenerAdapter precoListenerAdapter(PrecoConsumer consumidor) {
        MessageListenerAdapter adapter = new MessageListenerAdapter(consumidor, "consumidor");
        adapter.setMessageConverter(messageConverter());
        return adapter;
    }
}
