from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from faculty.filters import ExamDutyAllottmentFilter

from faculty.models import ExamDutyAllottment
# ,test1, test2
from faculty.serializers import ExamDutyGroupSerializer, ExamDutySerializer
# , test2Serializer
# Create your views here.
import pandas
from datetime import date, timedelta





class createExamDuty(APIView):

    def post(self, request):
        # try:
            data = request.data
            files=request.FILES
            print(data)
            label=data['label']
            startdate=data['startdate'].split("-")
            enddate=data['enddate'].split("-")
            startdate = date(int(startdate[0]),int(startdate[1]),int(startdate[2]))   
            enddate = date(int(enddate[0]),int(enddate[1]),int(enddate[2])+1)  
            daterange=list(pandas.date_range(startdate,enddate-timedelta(1),freq='d'))
            datelist=[]
            for i in daterange:
                dat=str(i).split()[0].split("-")
                dat=dat[::-1]
                dat="-".join(dat)
                datelist.append(dat)
            file1=files['file1']
            file2=files['file2']
            file3=files['file3']
            file4=files['file4']


            file_data = file1.read().decode("utf-8")		
            file1 = file_data.split("\n")[1:-1]
            for i in range(len(file1)):
                file1[i]=file1[i].split(",")
                file1[i][-1]=file1[i][-1][:-1]



            file_data = file2.read().decode("utf-8")		
            file2 = file_data.split("\n")[1:-1]
            for i in range(len(file2)):
                file2[i]=file2[i].split(",")
                file2[i][-1]=file2[i][-1][:-1]



            file_data = file3.read().decode("utf-8")		
            file3 = file_data.split("\n")[1:-1]
            for i in range(len(file3)):
                file3[i]=file3[i].split(",")
                file3[i][-1]=file3[i][-1][:-1]



            file_data = file4.read().decode("utf-8")		
            file4 = file_data.split("\n")[1:-1]
            for i in range(len(file4)):
                file4[i]=file4[i].split(",")
                file4[i][-1]=file4[i][-1][:-1]

            facultylist={}
            for i in file2:
                facultylist[i[0]]={}
                facultylist[i[0]]['designation']=i[1]
                facultylist[i[0]]['limit']=int(i[2])
                facultylist[i[0]]['days']=datelist.copy()
            for i in file1:
                if i[0] in facultylist:
                    if i[1] in facultylist[i[0]]['days']:
                        facultylist[i[0]]['days'].remove(i[1])
            result=[]
            for i in range(len(file4)):
                for j in range(int(file4[i][-1])):
                    resultdic={}
                    for k in facultylist:
                        if file4[i][1] in facultylist[k]['days'] and facultylist[k]['limit']>0:
                            facultylist[k]['days'].remove(file4[i][1])
                            facultylist[k]['limit']-=1
                            resultdic['label']=label
                            start=data['startdate']
                            end=data['enddate']
                            exam=file4[i][1]
                            exam=exam.split("-")[::-1]
                            exam="-".join(exam)
                            resultdic['start_date']=start
                            resultdic['end_date']=end
                            resultdic['exam_date']=exam
                            resultdic['bennett_email']=k
                            resultdic['subject']="test"
                            resultdic['room_no']=file4[i][0]
                            result.append(resultdic)
                            break
            # print(result)
            # print(len(result))


            print(file1)
            print()
            print(file2)
            print()
            print(file3)
            print()
            print(file4)
            print()
            print(facultylist)
            print()
            print()
            print()
            print()
            for i in result:
                examduty=ExamDutyAllottment(label=i['label'],bennett_email=i['bennett_email'],start_date=i['start_date'],end_date=i['end_date'],exam_date=i['exam_date'],room_no=i['room_no'],subject=i['subject'])
                examduty.save()
            return Response(status=status.HTTP_200_OK)
    
        # except Exception as e:
        #     return Response(e, status=status.HTTP_500_INTERNAL_SERVER_ERROR)



class getExamDutyGroup(APIView):
    def get(self, request):
        try:
            recommended = ExamDutyAllottment.objects.order_by().values('label','start_date','end_date').distinct()
            serializer = ExamDutyGroupSerializer(recommended, many=True)
            return Response(serializer.data,status=status.HTTP_200_OK)
        except Exception as e:
            return Response(e, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class getExamDutyFaculty(APIView):
    def get(self, request):
        try:
            data=ExamDutyAllottment.objects.all().order_by('exam_date')
            exam = ExamDutyAllottmentFilter(request.GET, queryset=data)  
            exam = exam.qs
            if exam.exists():
                serializer = ExamDutySerializer(exam, many=True)
                return Response(serializer.data,status=status.HTTP_200_OK)
            else:
                return Response(status=status.HTTP_204_NO_CONTENT)
        except Exception as e:
            return Response(e, status=status.HTTP_500_INTERNAL_SERVER_ERROR)














# class gett(APIView):
#     def get(self, request):
#         try:
#             user = request.user
#             recommended = test2.objects.all()
#             serializer = test2Serializer(recommended, many=True)
#             return Response(serializer.data,status=status.HTTP_200_OK)
#         except Exception as e:
#             return Response(e, status=status.HTTP_500_INTERNAL_SERVER_ERROR)



# class postt(APIView):
#     def post(self, request):
#         try:
#             data = request.data
#             cre=test2.objects.create(label=data['label'],bennett_email=data['email'])
#             return Response(status=status.HTTP_200_OK)
#         except Exception as e:
#             return Response(e, status=status.HTTP_500_INTERNAL_SERVER_ERROR)










# (bennett_email=user.username).order_by('-current_timestamp')[:25]
 # roomCreate = RecommendedBook.objects.create(
            #     bennett_email=StaffProfessionalDetails.objects.get(bennett_email=user.username),
            #     current_academic_year_code=AcademicYear.objects.get(status="ACTIVE"),
            #     target_course_id=CourseInformation.objects.get(course_id=data['target_course_id']),
            #     book_name=data['book_name'],
            #     author=data['author'],
            #     edition=data['edition'],
            #     publisher=data['publisher'],
            #     isbn=data['isbn'],
            #     quantity=data['quantity'],
            #     link=data['link'],
            #     comments=data['comments'],
            #     current_odd_even_sem = sem
            # )