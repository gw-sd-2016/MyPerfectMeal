#import "MedsTableViewController.h"
#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>

@interface MedsTableViewController ()

@end

@implementation MedsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];

    Medications = [[NSMutableArray alloc] initWithObjects:
                   @"Zyvox",@
                   "Zytiga",@
                   "Zyrtec",@
                   "Zyprexa",@
                   "Zubsolv",@
                   "Zovirax",@
                   "Zosyn",@
                   "Zostavax",@
                   "Zomig",@
                   "Zometa",@
                   "Zolpidem",@
                   "Zoloft",@
                   "Zofran",@
                   "Zocor",@
                   "Zithromax",@
                   "Ziac",@
                   "Zetia",@
                   "Zestril",@
                   "Zantac",@
                   "Zanaflex",@
                   "Yondelis",@
                   "Yervoy",@
                   "Yaz",@
                   "Yasmin",@
                   "Xyzal",@
                   "Xyrem",@
                   "Xtandi",@
                   "Xopenex",@
                   "Xolair",@
                   "Xofigo",@
                   "Xigduo XR",@
                   "Xifaxan",@
                   "Xiaflex",@
                   "Xgeva",@
                   "Xeomin",@
                   "Xenical",@
                   "Xenazine",@
                   "Xeloda",@
                   "Xeljanz",@
                   "Xarelto",@
                   "Xanax XR",@
                   "Xanax",@
                   "Xalkori",@
                   "Xalatan",@
                   "Wilate",@
                   "Wellbutrin",@
                   "Warfarin",@
                   "Vyvanse",@
                   "Vytorin",@
                   "Voltaren Gel",@
                   "Voltaren",@
                   "Vistaril",@
                   "Vimpat",@
                   "Vimovo",@
                   "Viibryd",@
                   "Victoza",@
                   "Vicodin",@
                   "Viagra",@
                   "Vesicare",@
                   "Verapamil",@
                   "Ventolin",@
                   "Venlafaxine",@
                   "Vasotec",@
                   "Vancomycin",@
                   "Valtrex",@
                   "Valium",@
                   "Valacyclovir",@
                   "Utibron Neohaler",@
                   "Uroxatral",@
                   "Ultresa",@
                   "Ultram",@
                   "Ultracet",@
                   "Ultane",@
                   "Uloric",@
                   "Ulesfia",@
                   "Uceris",@
                   "Tylenol",@
                   "Truvada",@
                   "Trileptal",@
                   "Tricor",@
                   "Triamterene",@
                   "Triamcinolone",@
                   "Trazodone",@
                   "Tramadol",@
                   "Tradjenta",@
                   "Toradol",@
                   "Topamax",@
                   "Tizanidine",@
                   "Tetracycline",@
                   "Testosterone",@
                   "Terazosin",@
                   "Tenormin",@
                   "Temazepam",@
                   "Tegretol",@
                   "Tamsulosin",@
                   "Tamoxifen",@
                   "Synthroid",@
                   "Symbicort",@
                   "Sudafed",@
                   "Suboxone",@
                   "Stribild",@
                   "Strattera",@
                   "Spironolactone",@
                   "Spiriva",@
                   "Soma",@
                   "Skelaxin",@
                   "Singulair",@
                   "Simvastatin",@
                   "Sildenafil",@
                   "Sertraline",@
                   "Seroquel",@
                   "Septra",@
                   "Sensipar",@
                   "Senna",@
                   "Savella",@
                   "Saphris",@
                   "Rocephin",@
                   "Robaxin",@
                   "Rituxan",@
                   "Ritalin",@
                   "risperidone",@
                   "Risperdal",@
                   "Rexulti",@
                   "Restoril",@
                   "Restasis",@
                   "Requip",@
                   "Renvela",@
                   "Remicade",@
                   "Remeron",@
                   "Relpax",@
                   "Reglan",@
                   "Reclast",@
                   "Rapaflo",@
                   "Ranitidine",@
                   "Ranexa",@
                   "Ramipril",@
                   "Qutenza",@
                   "Quillivant XR",@
                   "Quaaludes",@
                   "Qsymia",@
                   "QNASL",@
                   "Prozac",@
                   "Protonix",@
                   "Propranolol",@
                   "Promethazine",@
                   "Prolia",@
                   "Pristiq",@
                   "Prilosec",@
                   "Premarin",@
                   "Prednisone",@
                   "Pravastatin",@
                   "Pradaxa",@
                   "Potassium Chloride",@
                   "Plavix",@
                   "Plaquenil",@
                   "Phentermine",@
                   "Phenergan",@
                   "Percocet",@
                   "Paxil",@
                   "Paroxetine",@
                   "Paracetamol",@
                   "Oxycontin",@
                   "Oxycodone",@
                   "Oxybutynin",@
                   "Otezla",@
                   "Osphena",@
                   "Oseltamivir",@
                   "Ortho Tri-Cyclen",@
                   "Ortho Evra",@
                   "Orlistat",@
                   "Orkambi",@
                   "Orencia",@
                   "Opsumit",@
                   "Opdivo",@
                   "Opana",@
                   "Onglyza",@
                   "Onfi",@
                   "Ondansetron",@
                   "Omnicef",@
                   "Omeprazole",@
                   "Ofev",@
                   "Nuvigil",@
                   "NuvaRing",@
                   "Nucynta",@
                   "NovoLog",@
                   "Norvasc",@
                   "Nortriptyline",@
                   "Norco",@
                   "Nitrofurantoin",@
                   "Nifedipine",@
                   "Niaspan",@
                   "Niacin",@
                   "Nexium",@
                   "Neurontin",@
                   "Neupogen",@
                   "Nasonex",@
                   "Nasacort",@
                   "Naproxen",@
                   "Naprosyn",@
                   "Namenda",@
                   "Naloxone",@
                   "Myrbetriq",@
                   "Mucinex",@
                   "Motrin",@
                   "Morphine",@
                   "Mobic",@
                   "Mirtazapine",@
                   "MiraLax",@
                   "Metronidazole",@
                   "Metoprolol",@
                   "Metoclopramide",@
                   "Methylprednisolone",@
                   "Methylphenidate",@
                   "Methotrexate",@
                   "Methocarbamol",@
                   "Methadone",@
                   "Metformin",@
                   "Meloxicam",@
                   "Melatonin",@
                   "Meclizine",@
                   "Macrobid",@
                   "Lyrica",@
                   "Lunesta",@
                   "Lovenox",@
                   "Losartan",@
                   "Lortab",@
                   "Lorazepam",@
                   "Loratadine",@
                   "Lithium",@
                   "Lisinopril",@
                   "Lipitor",@
                   "Linzess",@
                   "Lexapro",@
                   "Levothyroxine",@
                   "Levemir",@
                   "Levaquin",@
                   "Latuda",@
                   "Lasix",@
                   "Lantus",@
                   "Lansoprazole",@
                   "Lamictal",@
                   "Kytril",@
                   "Kyprolis",@
                   "Kuvan",@
                   "Krill Oil",@
                   "Kombiglyze XR",@
                   "Klor-con",@
                   "Klonopin",@
                   "Kineret",@
                   "Keytruda",@
                   "Kerydin",@
                   "Keppra",@
                   "Kenalog",@
                   "Keflex",@
                   "Kcentra",@
                   "Kazano",@
                   "Kapvay",@
                   "Kaletra",@
                   "Kadian",@
                   "Kadcyla",@
                   "K-dur",@
                   "Juxtapid",@
                   "Juvisync",@
                   "Juvederm",@
                   "Jublia",@
                   "Jevtana",@
                   "Jetrea",@
                   "Jentadueto",@
                   "Jardiance",@
                   "Januvia",@
                   "Janumet",@
                   "Jalyn",@
                   "Jakafi",@
                   "Isosorbide",@
                   "Isentress",@
                   "Iressa",@
                   "Invokana",@
                   "Invokamet",@
                   "Invega",@
                   "Intuniv",@
                   "Integrilin",@
                   "Insulin",@
                   "Inlyta",@
                   "Injectafer",@
                   "Inderal",@
                   "Incruse Ellipta",@
                   "Implanon",@
                   "Imodium",@
                   "Imitrex",@
                   "Imdur",@
                   "Imbruvica",@
                   "Ibuprofen",@
                   "Ibrance",@
                   "Hyzaar",@
                   "Hytrin",@
                   "Hysingla ER",@
                   "Hylenex",@
                   "Hydroxyzine",@
                   "Hydroxychloroquine",@
                   "Hydrocodone",@
                   "Hydrochlorothiazide",@
                   "Humulin N",@
                   "Humulin",@
                   "Humira",@
                   "Humalog",@
                   "Horizant",@
                   "Hizentra",@
                   "Herceptin",@
                   "Heparin",@
                   "Hcg",@
                   "Havrix",@
                   "Harvoni",@
                   "Halaven",@
                   "Guaifenesin",@
                   "Gralise",@
                   "Glyxambi",@
                   "Glyburide",@
                   "Glucovance",@
                   "Glucotrol",@
                   "Glucophage",@
                   "Glipizide",@
                   "Gleevec",@
                   "Gilotrif",@
                   "Gilenya",@
                   "Geodon",@
                   "Gemzar",@
                   "Gemfibrozil",@
                   "Gelnique",@
                   "Gardasil",@
                   "Gamunex",@
                   "Gammagard",@
                   "Gablofen",@
                   "Gabapentin",@
                   "Furosemide",@
                   "Fosamax",@
                   "Forteo",@
                   "Folic Acid",@
                   "Focalin",@
                   "Fluoxetine",@
                   "Flovent",@
                   "Flonase",@
                   "Flomax",@
                   "Flexeril",@
                   "Flagyl",@
                   "Fish Oil",@
                   "Fioricet",@
                   "Fetzima",@
                   "Ferrous Sulfate",@
                   "Fentanyl",@
                   "Fenofibrate",@
                   "Femara",@
                   "Farxiga",@
                   "Famotidine",@
                   "Ezetimibe",@
                   "Exforge",@
                   "Exelon",@
                   "Excedrin",@
                   "Evista",@
                   "Etodolac",@
                   "Estradiol",@
                   "Estrace",@
                   "Erythromycin",@
                   "Epogen",@
                   "EpiPen",@
                   "Ephedrine",@
                   "Entresto",@
                   "Endocet",@
                   "Enbrel",@
                   "Enalapril",@
                   "Eliquis",@
                   "Elavil",@
                   "Effient",@
                   "Effexor",@
                   "DuoNeb",@
                   "Dulera",@
                   "Doxycycline",@
                   "Doxazosin",@
                   "Dopamine",@
                   "Ditropan",@
                   "Diphenhydramine",@
                   "Diovan",@
                   "Diltiazem",@
                   "Dilaudid",@
                   "Dilantin",@
                   "Digoxin",@
                   "Diflucan",@
                   "Diclofenac",@
                   "Diazepam",@
                   "Dextromethorphan",@
                   "Dexamethasone",@
                   "Depo-Provera",@
                   "Depakote",@
                   "Demerol",@
                   "Cymbalta",@
                   "Cyclobenzaprine",@
                   "Crestor",@
                   "Coumadin",@
                   "Coreg",@
                   "Concerta",@
                   "Clonidine",@
                   "Clonazepam",@
                   "Clindamycin",@
                   "Claritin",@
                   "Citalopram",@
                   "Ciprofloxacin",@
                   "Cipro",@
                   "Cialis",@
                   "Cetirizine",@
                   "Cephalexin",@
                   "Celexa",@
                   "Celebrex",@
                   "Carvedilol",@
                   "Carbamazepine",@
                   "Bystolic",@
                   "Bydureon",@
                   "Butrans",@
                   "Buspirone",@
                   "Buspar",@
                   "Bupropion",@
                   "Brintellix",@
                   "Brilinta",@
                   "Breo Ellipta",@
                   "Boniva",@
                   "Boniva",@
                   "Bisoprolol",@
                   "Biaxin",@
                   "Benicar",@
                   "Benadryl",@
                   "Belviq",@
                   "Belsomra",@
                   "Bactroban",@
                   "Bactrim",@
                   "Baclofen",@
                   "Azithromycin",@
                   "Augmentin",@
                   "Atorvastatin",@
                   "Ativan",@
                   "Atenolol",@
                   "Aspirin",@
                   "Aricept",@
                   "Amoxicillin",@
                   "Amlodipine",@
                   "Amitriptyline",@
                   "Amiodarone",@
                   "Ambien",@
                   "Alprazolam",@
                   "Allopurinol",@
                   "Aleve",@
                   "Albuterol",@
                   "Adderall",@
                   "Acyclovir",@
                   "Acetaminophen",@
                   "Abilify", nil];
    selectedMeds = [[NSMutableArray alloc] init];
    findSelectedMeds = [[PFUser currentUser] valueForKey:@"selectedMeds"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Medications count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
  

    
    cell.textLabel.text = [Medications objectAtIndex:indexPath.row];

    
    
    if ( [findSelectedMeds containsObject:[Medications objectAtIndex:indexPath.row]] ){
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[PFUser currentUser] saveInBackground];
        findSelectedMeds = [[PFUser currentUser] valueForKey:@"selectedMeds"];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[PFUser currentUser] saveInBackground];
        findSelectedMeds = [[PFUser currentUser] valueForKey:@"selectedMeds"];
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //user makes new selection
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        //check the cell selected
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [selectedMeds addObject:cell.textLabel.text];
        [[PFUser currentUser] setObject:selectedMeds forKey:@"selectedMeds"];
        [[PFUser currentUser] saveInBackground];
        findSelectedMeds = [[PFUser currentUser] valueForKey:@"selectedMeds"];
    
    
    }else{
        //user user selects something already pressed
        cell.accessoryType = UITableViewCellAccessoryNone;
        //remove it from the array
        [selectedMeds removeObject:cell.textLabel.text];
        //send off the data to parse and save it
        [[PFUser currentUser] removeObject:cell.textLabel.text forKey:@"selectedMeds"];
        [[PFUser currentUser] saveInBackground];
        findSelectedMeds = [[PFUser currentUser] valueForKey:@"selectedMeds"];

    }
}




@end
