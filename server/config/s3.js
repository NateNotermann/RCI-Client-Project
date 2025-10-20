const AWS = require('aws-sdk');
const multer = require('multer');
const multerS3 = require('multer-s3');

AWS.config.update({
  accessKeyId: process.env.newAWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.newAWS_SECRET_ACCESS_KEY,
  region: process.env.newAWS_REGION || 'us-east-1'
});

const s3 = new AWS.S3();

const upload = multer({
  storage: multerS3({
    s3: s3,
    bucket: process.env.S3_BUCKET_NAME,
    acl: 'public-read',
    key: function (req, file, cb) {
      cb(null, `images/${Date.now()}-${file.originalname}`);
    }
  })
});

module.exports = upload;