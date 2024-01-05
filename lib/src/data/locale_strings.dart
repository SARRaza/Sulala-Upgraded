import 'package:get/get.dart';

class LocalStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // English Language
        'en_US': {
          'Hello': 'Hello World',
          'Message': ' Welocome to Sulalh',
          'ChangeLang': 'Change Language',
          'SearchFarms': 'Search For Farms',
          'SearchAnimals': 'Search For Aniamls',
          'Findfarms': 'Find Farms',
          'Findanimals': 'Find Animals',
          'Wannajoin': 'Want To Start Your Farm Right Now & Join',
          'Joinnow': 'Join Now',
          'SignIn': 'Sign In',
          'Welcome': 'Welcome',
          '1 year': '1 year',
          'numYears': '%s years'
        },
        // Hindi Language
        'hi_IN': {
          'Hello': 'हैलो वर्ल्ड',
          'Message': 'सलालाह में आपका स्वागत है',
          'ChangeLang': 'भाषा बदलें',
          'SearchFarms': 'खेतों की खोज करें',
          'SearchAnimals': 'जानवरों की खोज करें',
          'Findfarms': 'फार्म खोजें',
          'Findanimals': 'पशु खोजें',
          'Wannajoin': 'अभी अपना फार्म शुरू करना चाहते हैं और जुड़ना चाहते हैं',
          'Joinnow': 'अब शामिल हों',
          'SignIn': 'दाखिल करना',
          'Welcome': 'स्वागत'
        },
        // Arabic Language
        'ar_SA': {
          // signup page localstrings starts
          "Welcome to Sulala!": "مرحبًا بكم في سولالا!",
          "Enter your Email Address, and we will send you confirmation code":
              "أدخل عنوان بريدك الإلكتروني، وسنرسل لك رمز التأكيد",
          "Enter your Phone Number, and we will send you confirmation code":
              "أدخل رقم هاتفك وسنرسل لك رمز التأكيد",
          'Continue': 'يكمل',
          'Invalid email address': 'عنوان البريد الإلكتروني غير صالح',
          'Enter Phone Number': 'أدخل رقم الهاتف',
          "Phone numbers can't have text":
              "لا يمكن أن تحتوي أرقام الهواتف على نص",
          "Invalid verification code.": "رمز التحقق غير صالح.",
          "Please, check the code or resend it again":
              "الرجاء التحقق من الرمز أو إعادة إرساله مرة أخرى",
          'Filter': 'منقي',
          '+971': '+٩٧١',
          '+966': '+٩٦٦',
          '+965': '+٩٦٥',
          '+964': '+٩٦٤',
          '+975': '+٩٧٥',
          '+976': '+٩٧٦',
          'Continue With Apple': 'تواصل مع أبل',
          'Continue With Google': 'تواصل مع جوجل',
          'Use Email Address': 'استخدم عنوان البريد الإلكتروني',
          'Enter Email': 'أدخل البريد الإلكتروني',
          'Use Phone Number': 'استخدم رقم الهاتف',
          'Enter Code': 'ادخل الرمز',
          "We sent a verification code on the following\nPhone number: ":
              "لقد قمنا بإرسال رمز التحقق على\nرقم الهاتف التالي: ",
          "We sent a verification code on the following\nEmail address: ":
              "لقد أرسلنا رمز التحقق على\nعنوان البريد الإلكتروني التالي: ",
          'We sent a verification code to the following':
              'قمنا بإرسال رمز التحقق إلى التالي',
          "Send New Code in: 00:": "أرسل رمزًا جديدًا في: 00:",
          'Phone Number:': 'رقم التليفون',
          'Send New Code': 'إرسال رمز جديد',
          'Confirm': 'يتأكد',
          'Email ID:': 'عنوان الايميل:',
          'Create Password': 'إنشاء كلمة المرور',
          'Password': 'كلمة المرور',
          'Confirm Password': 'تأكيد كلمة المرور',
          'Passwords do not match': 'كلمة المرور غير مطابقة',
          'Password should be at least 8 characters long and contain at least one number':
              'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل وتحتوي على رقم واحد على الأقل',
          // signup page localstrings ends
          //Account Setup - Profile Page Localstrings Starts
          'Add Personal Information': 'إضافة معلومات شخصية',
          "What's your name?": 'ما اسمك؟',
          'Enter First Name': 'أدخل الاسم الأول',
          'Enter Last Name': 'إدخال اسم آخر',
          'Contacts': 'جهات الاتصال',
          'Add contact details to help other people contact you for collaboration':
              'أضف تفاصيل الاتصال لمساعدة الأشخاص الآخرين على الاتصال بك للتعاون',
          'Email': 'بريد إلكتروني',
          'Phone Number': 'رقم التليفون',
          'Camera': 'آلة تصوير',
          'Gallery': 'صالة عرض',
          'Skip For Now': 'تخطي في الوقت الراهن',
          'Add Some Details': 'أضف بعض التفاصيل',
          'Add Profile Photo': 'إضافة صورة الشخصي',
          "What's your farm address?": 'ما هو عنوانك؟',
          'City': 'المدينة',
          'Country': 'دولة',
          'Add Photo': 'أضف صورة',
          // Account Setup - Profile Page Localstrings ends
          // Profile Main Page Starts
          'Profile': 'الملف الشخصي',
          'Edit Profile Information': 'تعديل معلومات الملف الشخصي',
          'John Smith': 'جون سميث',
          '123-456-7890': '123-456-7890',
          'Collaboration': 'التعاون',
          'Animals': 'الحيوانات',
          'Farm': 'المزرعة',
          'Head of Farm': 'رئيس المزرعة',
          'Collaborations': 'التعاون',
          'Accounts': 'الحسابات',
          'Payment Methods': 'طرق الدفع',
          'Subscriptions': 'الاشتراكات',
          'Notifications': 'الإشعارات',
          'Privacy and Security': 'الخصوصية والأمان',
          'App Settings': 'إعدادات التطبيق',
          'About App': 'حول التطبيق',
          'Customer Support': 'دعم العملاء',
          'Sign Out': 'تسجيل الخروج',
          'Sign Out?': 'هل تريد تسجيل الخروج؟',
          'Yes': 'نعم',
          'Cancel': 'إلغاء',
          'Head Of Farm': "رئيس المزرعة",
          // Profile Main Page Ends
          // Edit Profile Page Starts
          'Edit Personal Information': 'تعديل المعلومات الشخصية',
          'Change Photo': 'تغيير الصورة',
          'General Info': 'معلومات عامة',
          'First Name': 'الاسم الأول',
          'Last Name': 'الاسم الثاني',
          'Contact Details': 'تفاصيل الاتصال',
          'Email Address': 'عنوان البريد الإلكتروني',
          'Address': 'العنوان',
          "Farm Name": "اسم المزرعة",
          "Farm Owner": "صاحب المزرعة",
          "Farm Address": "عنوان المزرعة",
          'Save Changes': 'حفظ التغييرات',
          'Delete Photo': 'احذف الصورة الرمزية',
          // Edit Profile Page Ends
// About App Starts
          'Version Of The App: 0.1.12': 'إصدار التطبيق: 0.1.12',
          'Terms Of Use': 'شروط الاستخدام',
          'Privacy Policy': 'سياسة الخصوصية',
          // Join Now
          'What Is The Name Of Your Farm?': "ما هو اسم مزرعتك؟",
          'Field cannot be empty': "لا يمكن أن يكون الحقل فارغًا",
          "Who owns the farm?": "من يملك المزرعة؟",
          'Owner name': 'اسم المالك',

// About App Ends
// AppSettings Starts
          'Language Of The App': 'لغة التطبيق',
          'English': 'الإنجليزية',
          'Arabic': 'عربي',
          'French': 'الفرنسية',
          'Save': 'حفظ',
          'Language': 'اللغة',
// App Setting Ends
// Bottom NB Screen Starts
          'Home': 'الصفحة الرئيسية',
// Bottom NB Screen Ends
//List Of Staff -  Collaboration Starts
          'Invite A Member': 'دعوة عضو',
          'Share this link that will provide users access to your farm':
              'شارك هذا الرابط الذي سيوفر للمستخدمين الوصول إلى مزرعتك',
          'Copy Link': 'نسخ الرابط',
          'Your Staff': 'موظفيك',
          'Paul Rivera': 'بول ريفيرا',
          'Rebecca Wilson': 'ريبيكا ويلسون',
          'Patricia Williams': 'باتريشيا ويليامز',
          'Scott Simmons': 'سكوت سيمونز',
          'Lee Hall': 'لي هال', 'Helper': 'مساعد',
          'Worker': 'عامل',
          'Viewer': 'مشاهد',
          'Link Copied To Clipboard': 'تم نسخ الرابط إلى الحافظة',
          'Share Link': 'مشاركة الرابط',
// List Of Staff - Collaboration Ends
// Staff Details - Collaboration Starts
          'Member Of Your Staff': 'عضو في فريق العمل الخاص بك',
          'Delete Member?': 'حذف العضو؟',
          'Delete the member from your staffs?':
              "حذف العضو من فريق العمل الخاص بك؟",
          'This act can not be undone': "لا يمكن التراجع عن هذا الإجراء",
          'Delete': 'حذف',
          'Manage Permissions': 'إدارة الصلاحيات',
          'Role': 'الدور',
          'When the staff member is given permission to edit, they can add/edit data':
              'عندما يتم منح عضو الفريق الإذن بالتحرير، يمكنه إضافة/تعديل البيانات',
          'What Info Can This Member Edit?':
              'ما هي المعلومات التي يمكن لهذا العضو تحريرها؟',
          'Breeding Info': 'معلومات التربية',
          'Medical Info': 'معلومات طبية',
          'View Only': 'للاطلاع فقط',
          'Member Permissions': "صلاحيات العضو",
// Staff Details - Collaboration Ends
// Customer Support Starts
          'FAQs': 'الأسئلة الشائعة',
          'Question #1': 'سؤال #1',
          'Subtitle': 'عنوان فرعي',
          'Question #2': 'سؤال #2',
          'Question #3': 'سؤال #3',
          'Question #4': 'سؤال #4',
          'Question #5': 'سؤال #5',
          'WhatsApp': 'واتساب',
          'Chat With Support': 'الدردشة مع الدعم',
          '+965 96721717': '+965 96721717',
          'Call Us': 'اتصل بنا',
          'Contact Us': 'اتصل بنا',
          'Need Help': 'تحتاج إلى مساعدة',
// Customer Support Ends
// Notification Settings Starts
          'Pause All': 'إيقاف الكل',
          'System Notifications': 'إشعارات النظام',
          'Animal Management': 'إدارة الحيوانات',
// Notification Starts Ends
// Privacy & Security Starts
          'Privacy & Security': 'الخصوصية والأمان',
          'Allow Collaboration': 'السماح بالتعاون',
          'Show List Of Animals': 'عرض قائمة الحيوانات',
          'Show Family Tree': 'عرض شجرة العائلة',
          'Contact Information': 'معلومات الاتصال',
          'Show Contact Information': 'عرض معلومات الاتصال',
// Privacy & Security Ends
          'Hello': 'مرحبا بالعالم',
          'Message': 'مرحبا بكم في صلالة',
          'ChangeLang': 'تغيير اللغة',
          'SearchFarms': 'ابحث عن مزارع',
          'SearchAnimals': 'ابحث عن الحيوانات',
          'Findfarms': 'البحث عن مزارع',
          'Findanimals': 'البحث عن الحيوانات',
          'Wannajoin': 'تريد أن تبدأ مزرعتك الآن والانضمام',
          'Join Now': 'نضم الان',
          'Sign In': 'تسجيل الدخول',
          'Welcome': 'مرحباً',
          // Animal General Info Page Starts
          'My Farm': 'مزرعتي',
          'General': 'عام',
          'Breeding': 'تربية',
          'Medical': 'طبي',
          'Type': 'نوع',
          'Species': 'صِنف',
          'Sex': 'الجنس',
          'General Information': 'معلومات عامة',
          'Age': 'عمر',
          'Breed': 'تكاثر',
          'Date Of Hatching': "تاريخ الفقس",
          'Date Of Sale': 'الموعد للبيع',
          'Addtional Notes': 'ملاحظات إضافية',
          // Animal General Info Page Ends
          //  Create Animal Starts
          'Create': "يخلق",
          'Animal': 'حيوان',
          'Create Animal': "إنشاء حيوان",
          'Animal Type': "نوع الحيوان",
          'Mammal': 'الحيوان الثديي',
          'Oviparous': 'بياض',
          'Animal Species': "أنواع الحيوانات",
          'Animal Breeds': "السلالات الحيوانية",
          'Chosen Options': "الخيارات المختارة",
          'You can apply any changes': "يمكنك تطبيق أي تغييرات",
          'Name': 'اسم',
          'Enter Name': 'أدخل الاسم',
          'Family Tree': 'شجرة العائلة',
          "Add Parents If They're In The System":
              "أضف أولياء الأمور إذا كانوا في النظام",
          'Add Parents': "إضافة أولياء الأمور",
          'Sire (Father)': "سيدي (الأب)",
          'Dam (Mother)': "السد (الأم)",
          "Animal Sex": "الجنس الحيواني",
          'Add Children': "إضافة أطفال",
          'Unknown': 'غير معروف',
          'Male': 'رجل',
          'Female': 'أنثى',
          'Dates': 'تاريخ',
          'Date Of Birth': 'تاريخ الميلاد',
          'Add': 'يضيف',
          'Add Tags +': "إضافة علامات +",
          "Add Tag": "إضافة علامة",
          'Custom': 'حسب الطلب',
          'Fields': 'حقول النص',
          'Additional Notes': 'ملاحظات إضافية',
          'Add Additional Information If Needed':
              "أضف معلومات إضافية إذا لزم الأمر",
          "Search By Name Or ID": "البحث بالاسم أو المعرف",
          'Show More >': "إظهار المزيد >",
          'Create ': 'يخلق ',
          'Add Date +': "إضافة تاريخ +",
          "Add Custom Fields": "إضافة حقول مخصصة",
          'Add Custom Field +': "إضافة حقل مخصص +",
          //  Create Animal Ends
// Registered HomePage Starts
          'Current State': 'الوضع الحالي',
          'Borrowed': 'استعار',
          'Adopted': 'مُتَبنى',
          'Donated': "تم التبرع",
          'Escaped': "هرب",
          'Stolen': 'مسروق',
          'Transferred': 'نقل',
          'Medical State': "الحالة الطبية",
          'Injured': 'مصاب',
          'Sick': 'مريض',
          'Quarantined': "معزول",
          'Medication': 'دواء',
          'Testing': 'اختبارات',
          'Others': 'آحرون',
          'Sold': 'مُباع',
          'Dead': 'ميت',
          'Clear All': 'امسح الكل',
          'Apply': 'يتقدم',
          'Overview': 'ملخص',
          'Upcoming Events': 'الأحداث القادمة',
          // Guest Home Page
          'Searching \nfor farm?': "البحث عن المزرعة؟",
          'Searching\nfor animals?': "البحث عن الحيوانات؟",
          'Find farms': 'البحث عن مزارع',
          'Find animals': 'البحث عن الحيوانات',
          'Want to start your farm\nright now and join?':
              'هل تريد أن تبدأ مزرعتك\nالآن وتنضم إليها؟',
          'No Animals Added Yet': "لم تتم إضافة أي حيوانات بعد",
          'Sign In To Create A Farm & Add An Animal':
              "تسجيل الدخول لإنشاء مزرعة وإضافة حيوان",
          'ALL': 'الجميع',
          'Mammals': "الثدييات",
          'You have no upcoming events so far':
              "ليس لديك أي أحداث قادمة حتى الآن",
          // List of animals
          "Search by name or ID": "البحث بالاسم أو المعرف",
          'No Animals Found': "لم يتم العثور على حيوانات",
          'Try adjusting the filters': "حاول تعديل المرشحات",
          'Add Animal': "إضافة حيوان"
        },
      };
}
