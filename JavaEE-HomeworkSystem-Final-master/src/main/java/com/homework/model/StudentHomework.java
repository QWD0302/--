package com.homework.model;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name="student_homework")
public class StudentHomework{
    @EmbeddedId
    private StudentHomeworkKey key;

    @Column(name = "homework_title")
    private String homeworkTitle;

    @Column(name = "homework_content")
    private String homeworkContent;

    @Column(name = "submit_date")
    private Date submitDate;

    @Column(name = "score")
    private Integer score;

    @Column(name = "comment")
    private String comment;


    public StudentHomeworkKey getKey() {
        return key;
    }

    public void setKey(StudentHomeworkKey key) {
        this.key = key;
    }

    public String getHomeworkTitle() {
        return homeworkTitle;
    }

    public void setHomeworkTitle(String homeworkTitle) {
        this.homeworkTitle = homeworkTitle;
    }

    public String getHomeworkContent() {
        return homeworkContent;
    }

    public void setHomeworkContent(String homeworkContent) {
        this.homeworkContent = homeworkContent;
    }

    public Date getSubmitDate() {
        return submitDate;
    }

    public void setSubmitDate(Date submitDate) {
        this.submitDate = submitDate;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
