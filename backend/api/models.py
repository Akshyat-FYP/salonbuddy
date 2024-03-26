from django.db import models
from django.contrib.auth.models import AbstractUser
from django.db.models.signals import post_save
# Create your models here.

class User(AbstractUser):
    username = models.CharField(max_length =100)
    email = models.EmailField(unique=True)
    
    
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    def __str__(self):
        return self.username

class Profile(models.Model):
    user = models.OneToOneField(User,on_delete = models.CASCADE)
    full_name = models.CharField(max_length= 300)
    bio= models.CharField(max_length = 300)
    image = models.ImageField(default = "default.jpg", upload_to="user_images")
    verified = models.BooleanField(default = False)
    def __str__(self):
        return self.full_name
    
def create_user_profile(sender,instance,created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

def save_user_profile(sender,instance,**kwargs):
    instance.profile.save()

post_save.connect(create_user_profile, sender=User)
post_save.connect(save_user_profile,sender=User)

# Models for FYP

# from django.db import models

# class User(models.Model):
#     ROLE_CHOICES = [
#         ('barber', 'Barber'),
#         ('customer', 'Customer'),
#         ('admin', 'Admin'),
#     ]

#     username = models.CharField(max_length=100)
#     password = models.CharField(max_length=100)
#     email = models.EmailField()
#     phone = models.CharField(max_length=15)
#     address = models.TextField()
#     role = models.CharField(max_length=10, choices=ROLE_CHOICES)

# class Service(models.Model):
#     service_name = models.CharField(max_length=100)
#     description = models.TextField()
#     price = models.DecimalField(max_digits=10, decimal_places=2)

# class Booking(models.Model):
#     user = models.ForeignKey(User, on_delete=models.CASCADE)
#     service = models.ForeignKey(Service, on_delete=models.CASCADE)
#     barber_id = models.PositiveIntegerField()  # Assuming barber ID is just stored as a number
#     booking_date_time = models.DateTimeField()
#     status = models.CharField(max_length=20)
#     rating = models.IntegerField(null=True, blank=True)

# class History(models.Model):
#     user = models.ForeignKey(User, on_delete=models.CASCADE)
#     service = models.ForeignKey(Service, on_delete=models.CASCADE)
#     barber_id = models.PositiveIntegerField()  # Assuming barber ID is just stored as a number
#     booking_date_time = models.DateTimeField()
#     rating = models.IntegerField()

# class Notification(models.Model):
#     user = models.ForeignKey(User, on_delete=models.CASCADE)
#     message = models.TextField()
#     datetime = models.DateTimeField()

# class ServiceStatus(models.Model):
#     service = models.ForeignKey(Service, on_delete=models.CASCADE)
#     status = models.CharField(max_length=20)

# class BarberShop(models.Model):
#     name = models.CharField(max_length=100)
#     location = models.TextField()

# class Price(models.Model):
#     service = models.ForeignKey(Service, on_delete=models.CASCADE)
#     barber_shop = models.ForeignKey(BarberShop, on_delete=models.CASCADE)
#     price = models.DecimalField(max_digits=10, decimal_places=2)

# class Report(models.Model):
#     name = models.CharField(max_length=100)
#     description = models.TextField()
#     generated_datetime = models.DateTimeField()

# class Coupon(models.Model):
#     code = models.CharField(max_length=50, unique=True)
#     discount_percentage = models.DecimalField(max_digits=5, decimal_places=2)

#     def __str__(self):
#         return self.code
