package com.homework.model;

import lombok.Data;

import javax.persistence.Embeddable;
import java.io.Serializable;

@Embeddable
@Data
public class StudentHomeworkKey implements Serializable{

    private Long homeworkId;

    private String studentName;

    public StudentHomeworkKey(){

    }

    public StudentHomeworkKey(Long homeworkId, String studentName){
        this.homeworkId = homeworkId;
        this.studentName = studentName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o){
            return true;
        }
        if (o == null || getClass() != o.getClass()){
            return false;
        }

        StudentHomeworkKey key = (StudentHomeworkKey) o;

        if (homeworkId != null ? !homeworkId.equals(key.homeworkId) : key.homeworkId != null) {
            return false;
        }
        return studentName != null ? studentName.equals(key.studentName) : key.studentName == null;
    }

    @Override
    public int hashCode() {
        int result = homeworkId != null ? homeworkId.hashCode() : 0;
        result = 31 * result + (studentName != null ? studentName.hashCode() : 0);
        return result;
    }

    public Long getHomeworkId() {
        return homeworkId;
    }


    public void setHomeworkId(Long homeworkId) {
        this.homeworkId = homeworkId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
}
