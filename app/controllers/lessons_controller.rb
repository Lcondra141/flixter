class LessonsController < ApplicationController

    before_action :authenticate_user!
    before_action :require_authorized_for_current_course, only: [:show]

    def show
    end

    private

    def require_authorized_for_current_course   
        if ! current_user.enrolled_in?(current_course)
        redirect_to course_path(current_course), alert: 'You are not enrolled in this course. Enroll to view material'
    end
    end

    helper_method :current_lesson
    def current_lesson
        @current_lesson ||= Lesson.find(params[:id])
    end

    helper_method :current_course
    def current_course
        current_lesson.section.course
    end
end