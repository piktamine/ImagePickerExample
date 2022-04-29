//
//  ViewController.m
//  CamaraDeFotos
//
//  Created by Admin on 29/04/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) presentPickerControllerFotos:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES; //dejamos al usuario editar la foto antes de guardarla
    pickerController.sourceType = sourceType;
    
    [self presentViewController:pickerController animated:YES completion:nil];//presenta en la vista el picker para tomar la foto o para seleccionar de la galeria segun el source type
}


- (IBAction)takePhoto:(UIButton *)sender {
    //si tenemos disponible la camara
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [self presentPickerControllerFotos:UIImagePickerControllerSourceTypeCamera];
    }else{
        //NSLog(@"No hay camara disponible!");
        [self showMessagePantalla:@"No hay camara disponible!"];
    }
}

- (IBAction)selectPhoto:(UIButton *)sender {
    //si tenemos galeria de fotos disponible
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        [self presentPickerControllerFotos:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }else{
        [self showMessagePantalla:@"No hay carrete disponible!"];
        //NSLog(@"No hay carrete disponible!");
    }
}

//metodo que se ejecuta cuando tenemos algo en el picker de imagenes
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    //sacamos la imagen del picker
    UIImage *image = info[UIImagePickerControllerEditedImage];
    //le damos esa imagen al imageview
    self.imageView.image = image;
    
    //ocultamos picker
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//metodo que se ejecuta si el usuario cancela el picker
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //ocultamos picker
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) showMessagePantalla:(NSString *)mensaje{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Mensaje"
                message:mensaje
                preferredStyle:UIAlertControllerStyleAlert]; // 1
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    return;
                }];

        [alert addAction:firstAction];

        [self presentViewController:alert animated:YES completion:nil];
}

@end
