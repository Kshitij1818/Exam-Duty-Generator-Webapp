from rest_framework.serializers import ModelSerializer
from .models import ExamDutyAllottment

# , test1, test2


class ExamDutySerializer(ModelSerializer):
    class Meta:
        model = ExamDutyAllottment
        fields = '__all__'


class ExamDutyGroupSerializer(ModelSerializer):
    class Meta:
        model = ExamDutyAllottment
        fields = ['label','start_date','end_date']




# class test2Serializer(ModelSerializer):
#     class Meta:
#         model = test2
#         fields = '__all__'
#         depth=1