function previewFiles() {
  var preview_array = [];
  var file_array = [];
  var reader_array  = [];
  var file_length = document.querySelector('input[type=file]').files.length;
  for(var i=0; i<10; i++){
      document.querySelector('img[name="preview' + i + '"]').src = "";
  }
  for(var i=0; i<file_length; i++){
      preview_array.push(document.querySelector('img[name="preview' + i + '"]'));
      file_array.push(document.querySelector('input[type=file]').files[i]);
      reader_array.push(new FileReader());
  }

  if(file_length>0){
      reader_array[0].addEventListener("load", function () {
          preview_array[0].src = reader_array[0].result;
      }, false);
  }

  if(file_length>1){
      reader_array[1].addEventListener("load", function () {
          preview_array[1].src = reader_array[1].result;
      }, false);
  }

  if(file_length>2){
      reader_array[2].addEventListener("load", function () {
          preview_array[2].src = reader_array[2].result;
      }, false);
  }

  if(file_length>3){
    reader_array[3].addEventListener("load", function () {
        preview_array[3].src = reader_array[3].result;
    }, false);
  } 

  if(file_length>4){
    reader_array[4].addEventListener("load", function () {
        preview_array[4].src = reader_array[4].result;
    }, false);
  } 

  if(file_length>5){
    reader_array[5].addEventListener("load", function () {
        preview_array[5].src = reader_array[5].result;
    }, false);
  } 

  if(file_length>6){
    reader_array[6].addEventListener("load", function () {
        preview_array[6].src = reader_array[6].result;
    }, false);
  } 

  if(file_length>7){
    reader_array[7].addEventListener("load", function () {
        preview_array[7].src = reader_array[7].result;
    }, false);
  } 

  if(file_length>8){
    reader_array[8].addEventListener("load", function () {
        preview_array[8].src = reader_array[8].result;
    }, false);
  } 

  if(file_length>9){
    reader_array[9].addEventListener("load", function () {
        preview_array[9].src = reader_array[9].result;
    }, false);
  } 

  for(var i=0; i<file_length; i++){
      reader_array[i].readAsDataURL(file_array[i]);
  }
}