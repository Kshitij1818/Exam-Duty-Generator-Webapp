from django.db import models
from django.utils.timezone import now




class ExamDutyAllottment(models.Model):
    label=models.CharField(max_length=255, null=False)
    bennett_email =models.CharField(max_length=255, null=False)
    start_date= models.DateField()
    end_date= models.DateField()
    exam_date= models.DateField()                                 
    room_no = models.CharField(max_length=255)
    subject = models.CharField(max_length=255) 
    current_timestamp = models.DateTimeField(null=True, blank=True, editable=False)

    def save(self, *args, **kwargs):
        self.current_timestamp = now()
        super(ExamDutyAllottment, self).save(*args, **kwargs)








# class test1(models.Model):
#     x=models.ForeignKey(ExamDutyAllottment,on_delete=models.CASCADE)

#     def save(self, *args, **kwargs):
#         super(test1, self).save(*args, **kwargs)


# class test2(models.Model):
#     label=models.CharField(max_length=255, null=False,unique=True)
#     bennett_email =models.CharField(max_length=255, null=False)
#     img=models.ImageField(upload_to="media/")
#     def save(self, *args, **kwargs):
#         super(test2, self).save(*args, **kwargs)



