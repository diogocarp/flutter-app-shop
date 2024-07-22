package com.shopping.shop.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/qrcode")
public class QRCodeController {

    @GetMapping("/getQrCode")
    public ResponseEntity<byte[]> getQrCode(
            @RequestParam String nome,
            @RequestParam String cidade,
            @RequestParam String valor,
            @RequestParam String saida,
            @RequestParam String chave) {

        String url = String.format("https://gerarqrcodepix.com.br/api/v1?nome=%s&cidade=%s&valor=%s&saida=%s&chave=%s",
                nome, cidade, valor, saida, chave);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<byte[]> responseEntity = restTemplate.getForEntity(url, byte[].class);

        if (responseEntity.getStatusCode().is2xxSuccessful() && responseEntity.getBody() != null) {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_PNG);
            headers.add("Access-Control-Allow-Origin", "*");
            return ResponseEntity.ok().headers(headers).body(responseEntity.getBody());
        }

        return ResponseEntity.badRequest().build();
    }
}
