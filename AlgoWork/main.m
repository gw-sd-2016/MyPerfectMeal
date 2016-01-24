#import <Foundation/Foundation.h>

//#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        
        NSArray *allPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [allPaths objectAtIndex:0];
        NSString *pathForLog = [documentsDirectory stringByAppendingPathComponent:@"yourFile.txt"];
        
        freopen([pathForLog cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
        
        
        //====================================PULL HTML PAGE============================================
        NSArray *drugNames = @[@"Abilify",@"Acetaminophen",@"Acyclovir",@"Adderall",@"Albuterol",@"Aleve",@"Allopurinol",@"Alprazolam",@"Ambien",@"Amiodarone",@"Amitriptyline",@"Amlodipine",@"Amoxicillin",@"Aricept",@"Aspirin",@"Atenolol",@"Ativan",@"Atorvastatin",@"Augmentin",@"Azithromycin",@"Baclofen",@"Bactrim",@"Bactroban",@"Belsomra",@"Belviq",@"Benadryl",@"Benicar",@"Biaxin",@"Bisoprolol",@"Boniva",@"Breo Ellipta",@"Brilinta",@"Brintellix",@"Bupropion",@"Buspar",@"Buspirone",@"Butrans",@"Bydureon",@"Bystolic",@"Carbamazepine",@"Carvedilol",@"Celebrex",@"Celexa",@"Cephalexin",@"Cetirizine",@"Cialis",@"Cipro",@"Ciprofloxacin",@"Citalopram",@"Claritin",@"Clindamycin",@"Clonazepam",@"Clonidine",@"Concerta",@"Coreg",@"Coumadin",@"Crestor",@"Cyclobenzaprine",@"Cymbalta",@"Demerol",@"Depakote",@"Depo-Provera",@"Dexamethasone",@"Dextromethorphan",@"Diazepam",@"Diclofenac",@"Diflucan",@"Digoxin",@"Dilantin",@"Dilaudid",@"Diltiazem",@"Diovan",@"Diphenhydramine",@"Ditropan",@"Dopamine",@"Doxazosin",@"Doxycycline",@"Dulera",@"DuoNeb",
                               
                               
                                /*@"Effexor",@"Effient",@"Elavil",@"Eliquis",@"Enalapril",@"Enbrel",@"Endocet",@"Entresto",@"Ephedrine",@"EpiPen",@"Epogen",@"Erythromycin",@"Estrace",@"Estradiol",@"Etodolac",@"Evista",@"Excedrin",@"Exelon",@"Exforge",@"Ezetimibe",@"Famotidine",@"Farxiga",@"Femara",@"Fenofibrate",@"Fentanyl",@"Ferrous Sulfate",@"Fetzima",@"Fioricet",@"Fish Oil",@"Flagyl",@"Flexeril",@"Flomax",@"Flonase",@"Flovent",@"Fluoxetine",@"Focalin",@"Folic Acid",@"Forteo",@"Fosamax",@"Furosemide",@"Gabapentin",@"Gammagard",@"Gamunex",@"Gardasil",@"Gelnique",@"Gemfibrozil",@"Gemzar",@"Genvoya",@"Geodon",@"Gilenya",@"Gilotrif",@"Gleevec",@"Glipizide",@"Glucophage",@"Glucotrol",@"Glucovance",@"Glyburide",@"Glyxambi",@"Gralise",@"Guaifenesin",@"Halaven",@"Harvoni",@"Havrix",@"Hcg",@"Heparin",@"Herceptin",@"Hetlioz",@"Hizentra",@"Horizant",@"Humalog",@"Humira",@"Humulin",@"Humulin N",@"Hydrochlorothiazide",@"Hydrocodone",@"Hydroxychloroquine",@"Hydroxyzine",@"Hysingla ER",@"Hytrin",@"Hyzaar",@"Ibrance",@"Ibuprofen",@"Imbruvica",@"Imdur",@"Imitrex",@"Imodium",@"Implanon",
                                
                               
                                @"Incruse Ellipta",@"Inderal",@"Injectafer",@"Insulin",@"Integrilin",@"Intelence",@"Intermezzo",@"Intuniv",@"Invega",@"Invokamet",@"Invokana",@"Isentress",@"Isosorbide",@"Jakafi",@"Jalyn",@"Janumet",@"Januvia",@"Jardiance",@"Jentadueto",@"Jetrea",@"Jevtana",@"Jublia",@"Juvederm",@"Juvisync",@"Juxtapid",@"K-dur",@"Kadcyla",@"Kadian",@"Kaletra",@"Kalydeco",@"Kapvay",@"Kazano",@"Kcentra",@"Keflex",@"Kenalog",@"Keppra",@"Kerydin",@"Keytruda",@"Kineret",@"Klonopin",@"Klor-con",@"Kombiglyze XR",@"Krill Oil",@"Kyprolis",@"Kytril",@"Lamictal",@"Lansoprazole",@"Lantus",@"Lasix",@"Latuda",@"Levaquin",@"Levemir",@"Levothyroxine",@"Lexapro",@"Linzess",@"Lipitor",@"Lisinopril",@"Lithium",@"Loratadine",@"Lorazepam",
                                
                                
                                @"Lortab",@"Losartan",@"Lovenox",@"Lunesta",@"Lyrica",@"Macrobid",@"Meclizine",@"Melatonin",@"Meloxicam",@"Metformin",@"Methadone",@"Methocarbamol",@"Methotrexate",@"Methylphenidate",@"Methylprednisolone",@"Metoclopramide",@"Metoprolol",@"Metronidazole",@"MiraLax",@"Mirtazapine",@"Mobic",@"Morphine",@"Motrin",@"Mucinex",@"Myrbetriq",@"Naloxone",@"Namenda",@"Naprosyn",@"Naproxen",@"Nasonex",@"Neurontin",@"Nexium",@"Niacin",@"Niaspan",@"Nicotine",@"Nifedipine",@"Nitrofurantoin",@"Norco",@"Nortriptyline",@"Norvasc",@"NovoLog",@"Nucynta",@"Nuedexta",@"NuvaRing",@"Nuvigil",@"Ofev",@"Omeprazole",@"Omnicef",@"Ondansetron",@"Onfi",@"Onglyza",@"Opana",@"Opdivo",@"Opsumit",@"Orapred",@"Orencia",@"Orkambi",@"Orlistat",@"Ortho Tri-Cyclen",@"Oseltamivir",@"Osphena",@"Otezla",@"Oxybutynin",@"Oxycodone",@"Oxycontin",@"Paracetamol",@"Paroxetine",@"Paxil",@"Percocet",@"Phenergan",@"Phentermine",@"Phenytoin",@"Plaquenil",@"Plavix",@"Potassium Chloride",@"Pradaxa",@"Pravastatin",@"Prednisone",@"Premarin",@"Prilosec",@"Pristiq",@"Promethazine",@"Propranolol",@"Protonix",@"Prozac",@"QNASL",@"Qsymia",@"Quaaludes",@"Quillivant XR",@"Qutenza",@"Ramipril",
                                
                                @"Ranexa",@"Ranitidine",@"Reclast",@"Reglan",@"Relafen",@"Relpax",@"Remeron",@"Remicade",@"Renvela",@"Requip",@"Restasis",@"Restoril",@"Rexulti",@"Risperdal",@"risperidone",@"Ritalin",@"Rituxan",
                                
                                @"Robaxin",@"Rocephin",@"Saphris",@"Savella",@"Senna",@"Sensipar",@"Septra",@"Seroquel",@"Sertraline",@"Sildenafil",@"Simvastatin",@"Singulair",@"Skelaxin",@"Soma",@"Sonata",@"Spiriva",@"Spironolactone",@"Strattera",@"Suboxone",@"Sudafed",@"Symbicort",@"Synthroid",@"Tamoxifen",@"Tamsulosin",@"Tegretol",@"Temazepam",@"Terazosin",@"Testosterone",@"Tetracycline",@"Tizanidine",@"Topamax",@"Toradol",@"Toviaz",@"Tradjenta",@"Tramadol",@"Trazodone",@"Triamcinolone",@"Triamterene",@"Tricor",@"Trileptal",@"Truvada",@"Tylenol",@"Uceris",@"Ulesfia",@"Uloric",@"Ultane",@"Ultracet",@"Ultram",@"Ultresa",@"Uptravi",@"Uroxatral",@"Utibron-Neohaler",
                                
                                @"Valacyclovir",@"Valium",@"Valtrex",@"Vancomycin",@"Vasotec",@"Venlafaxine",@"Ventolin",@"Verapamil",@"Vesicare",@"Viagra",@"Vicodin",@"Victoza",@"Viibryd",@"Vimovo",@"Vimpat",@"Vistaril",@"Voltaren",@"Voltaren Gel",@"Vytorin",@"Vyvanse",@"Warfarin",@"Wellbutrin",@"Wilate",@"Xalatan",@"Xalkori",@"Xanax",@"Xanax XR",@"Xarelto",@"Xeljanz",@"Xeloda",@"Xenazine",@"Xenical",@"Xgeva",@"Xiaflex",@"Xifaxan",@"Xigduo XR",@"Xofigo",@"Xolair",@"Xopenex",@"Xtandi",@"Xyntha",@"Xyrem",@"Xyzal",@"Yasmin",@"Yaz",@"Yervoy",@"Yondelis",@"Zanaflex",@"Zantac",@"Zestoretic",@"Zestril",@"Zetia",@"Ziac",@"Zithromax",@"Zocor",@"Zofran",@"Zoloft",@"Zolpidem",@"Zometa",@"Zostavax",@"Zosyn",@"Zovirax",@"Zubsolv",@"Zyprexa",@"Zyrtec",@"Zytiga",@"Zyvox"
                               
                               
                               
                               */];
        //NSLog(@"%@", drugNames);
        
        
        
        for(int j = 0; j < drugNames.count; j++){
            NSMutableString *drugWebsites = [NSMutableString stringWithFormat:@"http://www.drugs.com/%@", drugNames[j]];
            NSLog(@"%@", drugNames[j]);
            NSURL *drugWebsite = [[NSURL alloc] initWithString:drugWebsites];
            NSString *webContents = [[NSString alloc] initWithContentsOfURL:drugWebsite];
            
            
            
            
            //====================================PULL HTML PAGE============================================
            
            
            
            //====================================STRIP HTML PAGE============================================
            
            NSScanner *Scanner;
            NSString *text = @"";
            Scanner = [NSScanner scannerWithString:webContents];
            
            while ([Scanner isAtEnd] == NO) {
                
                [Scanner scanUpToString:@"<" intoString:NULL] ;
                
                [Scanner scanUpToString:@">" intoString:&text] ;
                
                webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
                webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@{", text] withString:@""];
                webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@}", text] withString:@""];
                webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@/", text] withString:@""];
                webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@\"", text] withString:@""];
                webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@|", text] withString:@""];
                webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"google"] withString:@""];
                webContents = [webContents stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"tag.cmd.push(function() { tag.display('div-gpt-ddcad-2'); });"] withString:@""];
                
                
                webContents = [webContents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                
            }
            //========================================STRIP HTML PAGE================================================
            
            
            
            //====================================LOCATE AND SEPERATE WHAT IS I DRUG============================================
            
            /*
            NSString *webContents2 = webContents;
            NSScanner *theSecondScanner;
            NSString *whatIsDrug = nil;
            theSecondScanner = [NSScanner scannerWithString:webContents2];
            
            while ([theSecondScanner isAtEnd] == NO) {
                
                [theSecondScanner scanUpToString:@"what is" intoString:NULL] ;
                
                [theSecondScanner scanUpToString:@"important information" intoString:&whatIsDrug] ;
                
                whatIsDrug = [[whatIsDrug componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
                
                
            }
            
            NSLog(@"%@", whatIsDrug);
            
            */
            
            
            //====================================LOCATE AND SEPERATE WHAT IS I DRUG============================================
            
            
            
            
            //====================================LOCATE AND SEPERATE WHAT TO AVOID USING DRUG============================================
            
             NSString *webContents3 = webContents;
             NSScanner *theThirdScanner;
             NSString *thingsToAvoid = nil;
             theThirdScanner = [NSScanner scannerWithString:webContents3];
             
             while ([theThirdScanner isAtEnd] == NO) {
             
             [theThirdScanner scanUpToString:@"What should I avoid" intoString:NULL] ;
             
             [theThirdScanner scanUpToString:@"_ad_client" intoString:&thingsToAvoid];
             }
             
             NSLog(@"%@", thingsToAvoid);
            
            //====================================LOCATE AND SEPERATE WHAT TO AVOID USING DRUG============================================
            
            
            
            NSArray *medicalTerms = @[
                                      
                                      
                                      //THIRD LIST OF MEDICAL TERMS
                                      @"alcohol",@"pain",@"drinking",@"pressure",@"infection",@"heart",@"brain",@"muscle",@"arthritis",@"cholesterol",@"fever",@"depression",@"infections",@"diarrhea",@"diabetes",@"cancer",@"skin",@"anxiety",@"inflammatory",@"inflammation",@"hypertension",@"stroke",@"dizziness",@"headache",@"dizzy",@"bleeding",@"antidepressant",@"sugar",@"swelling",@"hiv",@"seizures",@"antibiotic",@"drowsiness",@"dehydrated",@"bacteria",@"lung",@"arteries",@"pregnancy",@"nervous",@"herpes",@"pregnant",@"depressive",@"nasal",@"allergic",@"panic",@"asthma",@"itching",@"virus",@"chronic",@"nausea",@"measles",@"ache",@"shingles",@"prostate",@"indomethacin",@"menstrual",@"aids",@"hives"
                                      
                                      
                                      
                                      
                                      /*SECOND LIST OF MEDICAL TERMS
                                       @"avoid",@"",@"alcohol",@"treat",@"medication",@"blood",@"pain",@"drinking",@"increase",@"pressure",@"prevent",@"infection",@"heart",@"brain",@"drug",@"muscle",@"aspirin",@"grapefruit",@"arthritis",@"cholesterol",@"disorder",@"anti",@"fever",@"depression",@"infections",@"disease",@"diarrhea",@"diabetes",@"liver",@"cancer",@"skin",@"anxiety",@"inflammatory",@"inflammation",@"stomach",@"block",@"hypertension",@"insulin",@"stroke",@"vaccine",@"vessels",@"potassium",@"dizziness",@"kidney",@"medications",@"ibuprofen",@"headache",@"dizzy",@"medical",@"bleeding",@"antidepressant",@"inhibitors",@"calcium",@"sugar",@"muscles",@"swelling",@"instructions",@"hiv",@"failure",@"seizures",@"antibiotic",@"drowsiness",@"reduces",@"dangerous",@"disorders",@"damage",@"dehydrated",@"bacteria",@"lung",@"arteries",@"lowering",@"supplements",@"pregnancy",@"reduce",@"narcotic",@"nervous",@"herpes",@"unbalanced",@"pregnant",@"depressive",@"moderate",@"health",@"problems",@"treating",@"nasal",@"allergic",@"aleve",@"motrin",@"panic",@"breast",@"water",@"sign",@"salt",@"oral",@"glucose",@"asthma",@"immune",@"itching",@"virus",@"orally",@"bone",@"chronic",@"mouth",@"fat",@"fatal",@"eating",@"condition",@"nausea",@"chest",@"pills",@"measles",@"hormones",@"breathing",@"causes",@"ache",@"shingles",@"urine",@"loss",@"foods",@"natural",@"prevents",@"care",@"prostate",@"changing",@"nose",@"indomethacin",@"menstrual",@"reducing",@"advil",@"aids",@"hormone",@"track",@"hives",@"injury",@"sodium",@"blockers",@"reaction",@"protect",@"tissue",@"bloody",@"ultresa"
                                       
                                       */
                                      
                                      
                                      
                                      
                                      
                                      /* FIRST LIST OF MEDICAL TERMS
                                       @"ablation",@
                                       "fever",@
                                       "reducer",@
                                       "anxiety",@
                                       "acetylcholine",@
                                       "action potentials",@
                                       "headache",@
                                       "ache",@
                                       "adenosine",@
                                       "afferent",@
                                       "menstrual",@
                                       "aging",@
                                       "AHA Scientific Statements",@
                                       "antidepressant",@
                                       "AIDS",@
                                       "alcohol",@
                                       "amino acids",@
                                       "amyloid",@
                                       "anastomosis",@
                                       "anemia",@
                                       "anesthesia",@
                                       "aneurysm",@
                                       "angina",@
                                       "angiogenesis",@
                                       "angiography",@
                                       "angioplasty",@
                                       "angiotensin",@
                                       "anisotropy",@
                                       "antiarrhythmia agents",@
                                       "antibodies",@
                                       "anticoagulants",@
                                       "antigens",@
                                       "antioxidants",@
                                       "aorta",@
                                       "apolipoproteins",@
                                       "apoptosis",@
                                       "arrhythmia",@
                                       "arteries",@
                                       "arteriosclerosis",@
                                       "aspirin",@
                                       "atherosclerosis",@
                                       "atrial flutter",@
                                       "atrial natriuretic factor",@
                                       "atrioventricular node",@
                                       "atrium",@
                                       "balloon",@
                                       "baroreceptors",@
                                       "biopsy",@
                                       "blood cells",@
                                       "blood flow",@
                                       "blood pressure",@
                                       "blood volume",@
                                       "bradykinin",@
                                       "brain",@
                                       "depresison",@
                                       "depressive disorder",@
                                       "panic disorder",@
                                       "anti-inflammatory",@
                                       "pain",@
                                       "arthritis",@
                                       "panic",@
                                       "bundle-branch block",@
                                       "bypass",@
                                       "calcium",@
                                       "capillaries",@
                                       "cardiac output",@
                                       "cardiac tamponade",@
                                       "cardiac volume",@
                                       "cardiomyopathy",@
                                       "cardioplegia",@
                                       "cardiopulmonary bypass",@
                                       "cardiopulmonary resuscitation",@
                                       "cardioversion",@
                                       "cardiovascular diseases",@
                                       "carotid arteries",@
                                       "catecholamines",@
                                       "catheter ablation",@
                                       "catheterization",@
                                       "catheters",@
                                       "cell adhesion molecules",@
                                       "cells",@
                                       "cerebral infarction",@
                                       "cerebral ischemia",@
                                       "cerebrovascular circulation",@
                                       "cerebrovascular disorders",@
                                       "cholesterol",@
                                       "circadian rhythm",@
                                       "circulation",@
                                       "claudication",@
                                       "Clinicopathological Conferences",@
                                       "coagulation",@
                                       "coarctation",@
                                       "cocaine",@
                                       "collagen",@
                                       "collateral circulation",@
                                       "complications",@
                                       "computers",@
                                       "conduction",@
                                       "contractility",@
                                       "contrast media",@
                                       "coronary disease",@
                                       "cost-benefit analysis",@
                                       "creatine kinase",@
                                       "death",@
                                       "defects",@
                                       "depression",@
                                       "defibrillation",@
                                       "depolarization",@
                                       "diabetes mellitus",@
                                       "diagnosis",@
                                       "diastole",@
                                       "diet",@
                                       "diuretics",@
                                       "drugs",@
                                       "ductus arteriosus",@
                                       "dynamics",@
                                       "echocardiography",@
                                       "edema",@
                                       "Editorials",@
                                       "elasticity",@
                                       "electrical stimulation",@
                                       "electrocardiography",@
                                       "electrophysiology",@
                                       "embolism",@
                                       "endocardium",@
                                       "endothelin",@
                                       "endothelium",@
                                       "endothelium-derived factors",@
                                       "enzymes",@
                                       "epidemiology",@
                                       "epithelium",@
                                       "excitation",@
                                       "exercise",@
                                       "extracorporeal circulation",@
                                       "fatty acids",@
                                       "fibrillation",@
                                       "fibrin",@
                                       "fibrinogen",@
                                       "fibrinolysis",@
                                       "fistula",@
                                       "follow-up studies",@
                                       "Fontan procedure",@
                                       "Fourier analysis",@
                                       "free radicals",@
                                       "gene therapy",@
                                       "genes",@
                                       "genetics",@
                                       "glucose",@
                                       "glycoproteins",@
                                       "grafting",@
                                       "growth substances",@
                                       "heart arrest",@
                                       "heart-assist device",@
                                       "heart block",@
                                       "heart defects",@
                                       "heart diseases",@
                                       "heart failure",@
                                       "heart rate",@
                                       "heart septal defects",@
                                       "hemodynamics",@
                                       "hemoglobin",@
                                       "hemorrhage",@
                                       "heparin",@
                                       "hibernation",@
                                       "hormones",@
                                       "hypercholesterolemia",@
                                       "hyperlipoproteinemia",@
                                       "hypertension",@
                                       "hypertrophy",@
                                       "hypoxia",@
                                       "imaging",@
                                       "immune system",@
                                       "immunohistochemistry",@
                                       "immunology",@
                                       "infarction",@
                                       "infection",@
                                       "inflammation",@
                                       "inhibitors",@
                                       "inotropic agents",@
                                       "insulin",@
                                       "interleukins",@
                                       "intervals",@
                                       "ischemia",@
                                       "isotopes",@
                                       "kidney",@
                                       "lasers",@
                                       "lesion",@
                                       "leukocytes",@
                                       "lifestyle",@
                                       "lipids",@
                                       "lipoproteins",@
                                       "liver",@
                                       "long-QT syndrome",@
                                       "lung",@
                                       "lymphocytes",@
                                       "magnetic resonance imaging",@
                                       "mapping",@
                                       "mechanics",@
                                       "men",@
                                       "meta-analysis",@
                                       "metabolism",@
                                       "metalloproteinases",@
                                       "microcirculation",@
                                       "microspheres",@
                                       "mitral valve",@
                                       "molecular biology",@
                                       "morbidity",@
                                       "morphogenesis",@
                                       "mortality",@
                                       "muscle",@
                                       "muscles",@
                                       "myocardial contraction",@
                                       "myocardial infarction",@
                                       "myocardial stunning",@
                                       "myocarditis",@
                                       "myocardium",@
                                       "myocytes",@
                                       "myoglobin",@
                                       "myosin",@
                                       "natriuretic peptides",@
                                       "nervous system",@
                                       "nitric oxide",@
                                       "nitric oxide synthase",@
                                       "nitroglycerin",@
                                       "norepinephrine",@
                                       "nuclear medicine",@
                                       "nutrition",@
                                       "obesity",@
                                       "occlusion",@
                                       "oxygen",@
                                       "pacemakers",@
                                       "pacing",@
                                       "pathology",@
                                       "patients",@
                                       "pediatrics",@
                                       "peptides",@
                                       "perfusion",@
                                       "pericarditis",@
                                       "pericardium",@
                                       "peripheral vascular disease",@
                                       "pharmacokinetics",@
                                       "pharmacology",@
                                       "phosphates",@
                                       "physiology",@
                                       "plaque",@
                                       "plasma",@
                                       "plasminogen",@
                                       "plasminogen activators",@
                                       "platelet-derived factors",@
                                       "platelets",@
                                       "polymerase chain reaction",@
                                       "population",@
                                       "potassium",@
                                       "potentials",@
                                       "pregnancy",@
                                       "pressure",@
                                       "prevention",@
                                       "prognosis",@
                                       "prostaglandins",@
                                       "prosthesis",@
                                       "proteins",@
                                       "pulmonary heart disease",@
                                       "radiography",@
                                       "radioisotopes",@
                                       "receptors",@
                                       "receptors, adrenergic, alpha",@
                                       "receptors, adrenergic, beta",@
                                       "reentry",@
                                       "reflex",@
                                       "regional blood flow",@
                                       "registries",@
                                       "regurgitation",@
                                       "rejection",@
                                       "remodeling",@
                                       "renin",@
                                       "reperfusion",@
                                       "respiration",@
                                       "restenosis",@
                                       "resuscitation",@
                                       "revascularization",@
                                       "rheumatic heart disease",@
                                       "risk factors",@
                                       "sarcoplasmic reticulum",@
                                       "scintigraphy",@
                                       "seasons",@
                                       "sex",@
                                       "shock",@
                                       "shunts",@
                                       "signal transduction",@
                                       "sinoatrial node",@
                                       "sleep",@
                                       "smoking",@
                                       "sodium",@
                                       "spectroscopy",@
                                       "statins",@
                                       "statistics",@
                                       "stenosis",@
                                       "stents",@
                                       "streptokinase",@
                                       "stress",@
                                       "stroke",@
                                       "structure",@
                                       "stunning, myocardial",@
                                       "surgery",@
                                       "survival",@
                                       "syncope",@
                                       "syndrome X",@
                                       "systole",@
                                       "tachyarrhythmias",@
                                       "tachycardia",@
                                       "tests",@
                                       "tetralogy of Fallot",@
                                       "thrombin",@
                                       "thrombolysis",@
                                       "thrombosis",@
                                       "thromboxane",@
                                       "thrombus",@
                                       "thyroid",@
                                       "tissue",@
                                       "tomography",@
                                       "torsade de pointes",@
                                       "transplantation",@
                                       "transposition of great vessels",@
                                       "trials",@
                                       "truncus arteriosus",@
                                       "ultrasonics",@
                                       "urokinase",@
                                       "vagus nerve",@
                                       "Valsalva",@
                                       "valves",@
                                       "valvuloplasty",@
                                       "vasculature",@
                                       "vasoconstriction",@
                                       "vasodilation",@
                                       "vasospasm",@
                                       "veins",@
                                       "ventilation",@
                                       "ventricles",@
                                       "vessels",@
                                       "viruses",@
                                       "vital statistics",@
                                       "von Willebrand factor",@
                                       "waves",@
                                       "Wolff-Parkinson-White syndrome",@
                                       "women",
                                       */];
            
            
            //NSLog(@"%@", medicalTerms);
            
            
            /*
            for(int i = 0; i < medicalTerms.count; i++)
                
            {
                if([whatIsDrug containsString:medicalTerms[i]]){
                    
                    NSLog(@"found the following words in the what is section                %@", medicalTerms[i]);
                    
                }
                
            }
              */
            
             for(int i = 0; i < medicalTerms.count; i++)
             
             {
             if([thingsToAvoid containsString:medicalTerms[i]]){
             NSLog(@"found the following words in the things to avoid section        %@", medicalTerms[i]);
             }
             
             }
            
            
            
        }
    }
    return 0;
}




