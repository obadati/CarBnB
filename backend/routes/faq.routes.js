const express = require("express");
const auth = require("../middleware/auth.js")
let router = express.Router();

const faqController = require("../controller/faq.controller.js");
  
router.get('/', auth, faqController.getAll);

router.get('/:faqId', auth, faqController.getFaqById)

router.post('/', auth, faqController.createFaq);

router.delete('/:faqId', auth, faqController.deleteFaqById)

router.put('/', auth, faqController.updateFaq)
  
module.exports = router;  