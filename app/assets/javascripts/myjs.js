const fs = require('fs');
const AWS = require('aws-sdk');
const s3 = new AWS.S3({
  accessKeyId: "AKIAJG6G53J23SGE5LOA",
  secretAccessKey: "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"
});
  function uploadFile(fileName){
    // Read content from the file
    const fileContent = fs.readFileSync(fileName);

    // Setting up S3 upload parameters
    const params = {

        Body: fileContent,
        Bucket: 'hcmadormitory',
        Key: 'bac.jpg',
        ACL: 'public-read',
    };

    // Uploading files to the bucket
    s3.upload(params, function(err, data) {
        if (err) {
            throw err;
        }
        console.log(`File uploaded successfully. ${data.Location}`);
    });
};


// var allImage = [] 
//   let myForm = document.getElementById('myForm');
//   let formData = new FormData(myForm);
//   // console.log(formData.get('content'))
//   function generatePreviewImage(image){
//     var index = 0;
//     count = image.files.length;
//     uploadFile(image.files[0])

//     for (let i = 0; i < image.files.length; i++) {
//       $('#preview_image').append(`<div class='card' style="max-height: 20rem" id="image_${index}">
//                                 <i class="ui window close outline icon" style="position: absolute; top: 0.5rem; right: 0.5rem; cursor: pointer;", onclick="removeImage(this)"></i>
//                                 <img style="width: 100%; height: 100%;" src='${URL.createObjectURL(image.files[i])}' />
//                                 </div>`)
//     }
//     // $('#preview_image').append(`<div class="card" style="height: 20rem", id="preview_image_card">
//     //         <input type="file" class="inputfile" id="embedpollfileinput" onchange="generatePreviewImage(this)" style="width: 100%; height: 100%" multiple/>
//     //         <label for="embedpollfileinput" class="ui button" style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center">
//     //           <i class="ui plus icon"></i>
//     //         </label>
//     //       </div>`)
//     let myFormImage = document.getElementById('myForm');
//     let formDataImage = new FormData(myForm);
//     index++;
//     for (let index = 0; index < formDataImage.getAll("images_input").length; index++) {
//       formData.append('images', formDataImage.getAll("images_input")[index]);
//     }
//   }

//   function removeImage(_this){
//     const preview_images = Array.prototype.slice.call( document.getElementById('preview_image').children )
//     $(_this).parent().remove();
//     const index =  preview_images.indexOf( _this.parentElement )
//     let images = formData.getAll("images")
//     images.splice(index-1, 1)
//     formData.delete('images')
//     for (let index = 0; index < images.length; index++) {
//       formData.append('images', images[index])
//     }
//   }

//   function createSubmit(e){
//     let formdatapost = new FormData(document.getElementById('myForm'));
//     let images = formData.getAll('images');
//     for (let i = 0; i < images.length; i++) {
//       formdatapost.append(`images[]`, images[i])
//     }
//     formdatapost.delete('images_input')
//     formdatapost.delete('content')
//     // console.log(formdatapost.get('content'))
//     x = document.querySelector('[role="textbox"]');
//     var post_content = x.innerHTML
//     formdatapost.append('content', post_content)
//     e.preventDefault();

//     $.ajax({
//       type: "POST",
//       url: "/manager/post-management/create",
//       processData: false,
//       contentType: false,
//       cache: false,
//       mimeType: 'multipart/form-data',
//       data: formdatapost,
//       success: function(result){
//         console.log(result)
//         let result_html = document.createElement('tr')
//         result_html.innerHTML = result
//         document.querySelector('#post_list').append(result_html)
//       },
//       error: function (error) {
//         console.log(error)
//         console.log("fails")
//       }
//     })
//   }