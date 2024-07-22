package com.microservice.estoquepreco.controller;

import constants.RabbitmqConstants;
import dto.PrecoDto;
import com.microservice.estoquepreco.service.RabbitmqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "preco")
public class PrecoController {

    @Autowired
    private RabbitmqService rabbitmqService;

    @PutMapping()
    private ResponseEntity alteraPreco(@RequestBody PrecoDto precoDto){
        this.rabbitmqService.enviaMensagem(RabbitmqConstants.FILA_PRECO, precoDto);
        return new ResponseEntity(HttpStatus.OK);
    }
}
