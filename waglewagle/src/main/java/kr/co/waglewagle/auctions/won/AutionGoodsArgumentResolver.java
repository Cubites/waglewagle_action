package kr.co.waglewagle.auctions.won;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;

import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import kr.co.waglewagle.auctions.mapper.AuctionsMapper;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class AutionGoodsArgumentResolver implements HandlerMethodArgumentResolver{
   
   @Autowired
   private AuctionsMapper mapper;
   
   
   @Override
   public boolean supportsParameter(MethodParameter parameter) {
      boolean hasAnnotaion = parameter.hasParameterAnnotation(AuctionIng.class);
      boolean hasAssginedFrom = Integer.class.isAssignableFrom(parameter.getParameterType());
      
      return hasAnnotaion && hasAssginedFrom;
   }

   @Override
   public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
         NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
            
      HttpServletRequest request = (HttpServletRequest)webRequest.getNativeRequest();
      String uri = request.getRequestURI();
      Integer goods_id = Integer.parseInt( uri.substring(uri.lastIndexOf("/")+1));
      Integer result = mapper.checkAuctionIng(goods_id);
      
      if(result == 0) {
         return null;
      }
      
         
      return goods_id;
   }

}

