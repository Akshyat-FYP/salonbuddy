# Generated by Django 5.0.3 on 2024-04-06 03:05

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0009_alter_appointment_style_of_cut'),
    ]

    operations = [
        migrations.AddField(
            model_name='appointment',
            name='verified',
            field=models.BooleanField(default=False),
        ),
    ]
