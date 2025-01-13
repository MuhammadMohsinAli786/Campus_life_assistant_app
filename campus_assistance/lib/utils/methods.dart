double map({required double inputlo,required double inputhi,required double outputlo,double? outputhi,required double val}) =>outputlo +inputlo +((outputhi! - outputlo) / (inputhi - inputlo)) * val;

