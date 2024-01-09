package kr.co.waglewagle.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatVO {
   private Integer chat_id;
   private Integer chat_send;
   private Integer chat_recieve;
   private String chat_content;
   private Date chat_date;
   private Integer goods_id;
}
