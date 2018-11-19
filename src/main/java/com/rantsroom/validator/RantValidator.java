package com.rantsroom.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.rantsroom.model.Rant;

@Component
public class RantValidator implements Validator{
	
	@Override
	public boolean supports(Class<?> clazz) {
		return Rant.class.equals(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		Rant rant = (Rant) target;
		
		//Rant title validation
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "error.titleEmpty");
        if (rant.getRantTitle().length() > 99) {
            errors.rejectValue("title", "Size.rantForm.title");
        }
        
      //Rant description validation
  		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "rant", "error.rantEmpty");
          if (rant.getRantDesc().length() > 999) {
              errors.rejectValue("rant", "Size.rant.title");
          }                		  
	}

}
