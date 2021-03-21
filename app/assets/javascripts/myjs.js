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
