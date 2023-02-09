import django_filters

from faculty.models import ExamDutyAllottment

class ExamDutyAllottmentFilter(django_filters.FilterSet):
    label = django_filters.CharFilter(lookup_expr='iexact',field_name="label",label="label")
    bennett_email=django_filters.CharFilter(lookup_expr='iexact',field_name="bennett_email",label="bennett_email")
    subject=django_filters.CharFilter(lookup_expr='iexact',field_name="subject",label="subject")

    class Meta:
        model = ExamDutyAllottment
        fields = ['label','bennett_email','start_date','end_date','exam_date','room_no','subject']